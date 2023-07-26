Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD4576283E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 03:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGZBjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 21:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGZBjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:39:41 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0BE26B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 18:39:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5700b15c12fso73114827b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 18:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690335578; x=1690940378;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4+spZWgq0eS9irqfihzysgfAABYfYXXmt6SNBBeIWA=;
        b=MZxYT2MdZ0Omg+tGFjNofeHkNy3Qahh2PBaeRGC1CPgAvaobe+CbfQzviGlH2bRGld
         yZXqVlc4rdM7Hn/0uDpIIp7PtuXFyXV1rOEzEcPsa6KfHQ8WsO8NrD1ggf9GGi+atd7F
         nKDBxVEOzhZviRxzmHMsde7z3UqWCZoSc0lNm1akA/R8EHPW9npAKef3Z/pjfCjWQWBN
         xmycegOze/hxSYYenv2HpylIbUfqF9JiHr0gy59wVHZoy8dXEq78uEH7BvhlWGHxnNVM
         Pm/pG6h4Z3mK+EEHLb2xoyIraXRTQQ+dd3MgzFr8XAVX1x101W0eH3RmqvYAcZ2a0tMf
         tMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690335578; x=1690940378;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4+spZWgq0eS9irqfihzysgfAABYfYXXmt6SNBBeIWA=;
        b=XbJLEREbN92nw88J2NjP26xJAylt9wO/XaOA3JY3fqSMjISz7DXCSha2bTb4HhfQ8X
         vr8MwHdtWGlvpcqBm5P7vhnpmJEmnJGqjWk88wWGfHIcV00/NyC8w7w2VQAodYdQzp32
         CGMvzam39XS5CNMddltyvs3R7kGJ8uoMvkTOAWMS00Mouu+f3dKetPC519Z0SjVTK3v2
         EgfZmDpxElKqQrP/ttG728/gbxCv0ZgOawnTLM2tqF4MdXnNM9NZ6mE3XBh7pkRhIqSx
         jB1zy3HftKSrvr2oHHWVrnp/vg4gKgf0mSNN9CH0ZVHnyUFMV8mMZx4LG5TDhbJh0uTV
         sJ6w==
X-Gm-Message-State: ABy/qLZoonmzGXwjK5xexn0fWPYMSW7RpSpjfEvxOjvVmz/N4ldVQ7Y2
        1Xl9QLkKlLat4gM/97lTNXHAPA==
X-Google-Smtp-Source: APBJJlHxqCs0/k9opPHZr1oFjC/IjLn2NWFjtEyuaFY5bDdVyDOg3sTAz2vkUnxY9z5liUX1UEynKA==
X-Received: by 2002:a81:46c3:0:b0:56d:2189:d87a with SMTP id t186-20020a8146c3000000b0056d2189d87amr821699ywa.15.1690335578030;
        Tue, 25 Jul 2023 18:39:38 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s10-20020a5b044a000000b00c654cc439fesm3165326ybp.52.2023.07.25.18.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 18:39:37 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:39:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jeff Layton <jlayton@kernel.org>
cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Anthony Iliopoulos <ailiop@suse.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 3/7] tmpfs: bump the mtime/ctime/iversion when page
 becomes writeable
In-Reply-To: <20230725-mgctime-v6-3-a794c2b7abca@kernel.org>
Message-ID: <42c5bbe-a7a4-3546-e898-3f33bd71b062@google.com>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org> <20230725-mgctime-v6-3-a794c2b7abca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Jul 2023, Jeff Layton wrote:

> Most filesystems that use the pagecache will update the mtime, ctime,
> and change attribute when a page becomes writeable. Add a page_mkwrite
> operation for tmpfs and just use it to bump the mtime, ctime and change
> attribute.
> 
> This fixes xfstest generic/080 on tmpfs.

Huh.  I didn't notice when this one crept into the multigrain series.

I'm inclined to NAK this patch: at the very least, it does not belong
in the series, but should be discussed separately.

Yes, tmpfs does not and never has used page_mkwrite, and gains some
performance advantage from that.  Nobody has ever asked for this
change before, or not that I recall.

Please drop it from the series: and if you feel strongly, or know
strong reasons why tmpfs suddenly needs to use page_mkwrite now,
please argue them separately.  To pass generic/080 is not enough.

Thanks,
Hugh

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  mm/shmem.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b154af49d2df..654d9a585820 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2169,6 +2169,16 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +static vm_fault_t shmem_page_mkwrite(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	file_update_time(vma->vm_file);
> +	inode_inc_iversion(inode);
> +	return 0;
> +}
> +
>  unsigned long shmem_get_unmapped_area(struct file *file,
>  				      unsigned long uaddr, unsigned long len,
>  				      unsigned long pgoff, unsigned long flags)
> @@ -4210,6 +4220,7 @@ static const struct super_operations shmem_ops = {
>  
>  static const struct vm_operations_struct shmem_vm_ops = {
>  	.fault		= shmem_fault,
> +	.page_mkwrite	= shmem_page_mkwrite,
>  	.map_pages	= filemap_map_pages,
>  #ifdef CONFIG_NUMA
>  	.set_policy     = shmem_set_policy,
> @@ -4219,6 +4230,7 @@ static const struct vm_operations_struct shmem_vm_ops = {
>  
>  static const struct vm_operations_struct shmem_anon_vm_ops = {
>  	.fault		= shmem_fault,
> +	.page_mkwrite	= shmem_page_mkwrite,
>  	.map_pages	= filemap_map_pages,
>  #ifdef CONFIG_NUMA
>  	.set_policy     = shmem_set_policy,
> 
> -- 
> 2.41.0
