Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C016D3CF420
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 07:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhGTFNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 01:13:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42828 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234441AbhGTFNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:13:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgOhWzz_1626760458;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UgOhWzz_1626760458)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 13:54:18 +0800
Subject: Re: [PATCH v2 2/4] fuse: Make DAX mount option a tri-state
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-3-jefflexu@linux.alibaba.com>
 <YPW+NgbMDnGQ2UPI@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <8ffadee4-701c-52db-31b3-fd27dc6422d6@linux.alibaba.com>
Date:   Tue, 20 Jul 2021 13:54:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPW+NgbMDnGQ2UPI@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/20/21 2:02 AM, Vivek Goyal wrote:
> On Fri, Jul 16, 2021 at 06:47:51PM +0800, Jeffle Xu wrote:
>> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
>> operate the same which is equivalent to 'always'.
>>
>> By the time this patch is applied, 'inode' mode is actually equal to
>> 'always' mode, before the per-file DAX flag is introduced in the
>> following patch.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/fuse/dax.c       | 13 ++++++++++++-
>>  fs/fuse/fuse_i.h    | 11 +++++++++--
>>  fs/fuse/inode.c     |  2 +-
>>  fs/fuse/virtio_fs.c | 16 ++++++++++++++--
>>  4 files changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>> index c6f4e82e65f3..a478e824c2d0 100644
>> --- a/fs/fuse/dax.c
>> +++ b/fs/fuse/dax.c
>> @@ -70,6 +70,9 @@ struct fuse_inode_dax {
>>  };
>>  
>>  struct fuse_conn_dax {
>> +	/** dax mode: FUSE_DAX_MOUNT_* (always, never or per-file) **/
>> +	unsigned int mode;
> 
> Why "/**" ?

I copied this comment style from fuse in v4.19... Anyway, I will fix this.

> 
> How about make it something like "enum fuse_dax_mode mode" instead?
> 
> enum fuse_dax_mode dax_mode;

OK.

> 
>> +
>>  	/* DAX device */
>>  	struct dax_device *dev;
>>  
>> @@ -1288,7 +1291,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
>>  	return ret;
>>  }
>>  
>> -int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
>> +int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
>> +			struct dax_device *dax_dev)
>>  {
>>  	struct fuse_conn_dax *fcd;
>>  	int err;
>> @@ -1301,6 +1305,7 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
>>  		return -ENOMEM;
>>  
>>  	spin_lock_init(&fcd->lock);
>> +	fcd->mode = mode;
>>  	fcd->dev = dax_dev;
>>  	err = fuse_dax_mem_range_init(fcd);
>>  	if (err) {
>> @@ -1339,10 +1344,16 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>>  static bool fuse_should_enable_dax(struct inode *inode)
>>  {
>>  	struct fuse_conn *fc = get_fuse_conn(inode);
>> +	unsigned int mode;
>>  
>>  	if (!fc->dax)
>>  		return false;
>>  
>> +	mode = fc->dax->mode;
>> +
>> +	if (mode == FUSE_DAX_MOUNT_NEVER)
>> +		return false;
>> +
>>  	return true;
>>  }
>>  
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index 07829ce78695..f29018323845 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -487,6 +487,12 @@ struct fuse_dev {
>>  	struct list_head entry;
>>  };
>>  
>> +enum {
> And this becomes.
> 
> enum fuse_dax_mode {
> };

OK.

> 
>> +	FUSE_DAX_MOUNT_INODE,
>> +	FUSE_DAX_MOUNT_ALWAYS,
>> +	FUSE_DAX_MOUNT_NEVER,
>> +};
> 
> How about getting rid of "MOUNT" and just do.
> 
> 	FUSE_DAX_INODE,
> 	FUSE_DAX_ALWAYS,
> 	FUSE_DAX_NEVER,

OK.

> 
>> +
>>  struct fuse_fs_context {
>>  	int fd;
>>  	unsigned int rootmode;
>> @@ -503,7 +509,7 @@ struct fuse_fs_context {
>>  	bool no_control:1;
>>  	bool no_force_umount:1;
>>  	bool legacy_opts_show:1;
>> -	bool dax:1;
>> +	unsigned int dax;
> 
> enum fuse_dax_mode dax_mode;

OK.

> 
>>  	unsigned int max_read;
>>  	unsigned int blksize;
>>  	const char *subtype;
>> @@ -1242,7 +1248,8 @@ ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
>>  ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
>>  int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
>>  int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start, u64 dmap_end);
>> -int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev);
>> +int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
> 						   ^^
> 						enum fuse_dax_mode dax_mode

OK.

>> +			struct dax_device *dax_dev);
>>  void fuse_dax_conn_free(struct fuse_conn *fc);
>>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>>  void fuse_dax_inode_init(struct inode *inode);
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index b9beb39a4a18..f6b46395edb2 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1434,7 +1434,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>>  	sb->s_subtype = ctx->subtype;
>>  	ctx->subtype = NULL;
>>  	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
>> -		err = fuse_dax_conn_alloc(fc, ctx->dax_dev);
>> +		err = fuse_dax_conn_alloc(fc, ctx->dax, ctx->dax_dev);
>>  		if (err)
>>  			goto err;
>>  	}
>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index 8f52cdaa8445..561f711d1945 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
>> @@ -88,12 +88,21 @@ struct virtio_fs_req_work {
>>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>>  				 struct fuse_req *req, bool in_flight);
>>  
>> +static const struct constant_table dax_param_enums[] = {
>> +	{"inode",	FUSE_DAX_MOUNT_INODE },
>> +	{"always",	FUSE_DAX_MOUNT_ALWAYS },
>> +	{"never",	FUSE_DAX_MOUNT_NEVER },
>> +	{}
>> +};
>> +
>>  enum {
>>  	OPT_DAX,
>> +	OPT_DAX_ENUM,
>>  };
>>  
>>  static const struct fs_parameter_spec virtio_fs_parameters[] = {
>>  	fsparam_flag("dax", OPT_DAX),
>> +	fsparam_enum("dax", OPT_DAX_ENUM, dax_param_enums),
>>  	{}
>>  };
>>  
>> @@ -110,7 +119,10 @@ static int virtio_fs_parse_param(struct fs_context *fc,
>>  
>>  	switch (opt) {
>>  	case OPT_DAX:
>> -		ctx->dax = 1;
>> +		ctx->dax = FUSE_DAX_MOUNT_ALWAYS;
>> +		break;
>> +	case OPT_DAX_ENUM:
>> +		ctx->dax = result.uint_32;
> 
> Do we want to check here if result.uint_32 has one of the allowed values.
> FUSE_DAX_MOUNT_INODE, FUSE_DAX_MOUNT_ALWAYS or FUSE_DAX_MOUNT_NEVER. Or
> VFS has already taken care of that?

VFS will ensure that the returned result.uint_32 can only be among the
values defined in 'struct constant_table', or fs_parse() will return
-EINVAL.

-- 
Thanks,
Jeffle
