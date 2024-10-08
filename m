Return-Path: <linux-fsdevel+bounces-31269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A72993CCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 04:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01246B23CF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 02:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90FA1F60A;
	Tue,  8 Oct 2024 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rarWP4vq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AC1E521
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353946; cv=none; b=a2aeRfBHa4yOQiZy47czBGBFaFItTo3AeQdCyfiveVMWyP7pWlQRUV8bLu8jVUc0G6heCCu0s0m1glvEFApXcwSjRkxwveroGCO16dS3WEtt+sPxCILJ4CQWzsIt+seHuqbO3rUeVJOCzMX+jONJ0wUKG64wAQ30NRmdQZu+gkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353946; c=relaxed/simple;
	bh=TUv8QlxEawPB0IiJEST7nlTX4qtq7k4yi8QGDpQ6ewc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZAo1CnXcmas32kNM9w7yN0NYqSymIyt2CLu39r2UC8S70a0BGld5+gdTd/cbVqkxtdJcmtf7vMs84GH/VhXcMMl/Nsq1tvJ9CulQfsQSfIky8r6TK7ZAEahza4z5gfrh1GHAlVZQCSvUQ4rIEWtY6mlTfPlR+dVLnPL9SIJ3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rarWP4vq; arc=none smtp.client-ip=47.90.199.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728353932; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/QfZfSGLLAY055ZVAzgt+JLVSi3pnbXH30CE8nx9K/E=;
	b=rarWP4vqh/Vmf/HlCP4eSY4Erl28CaiRI/IWChj4REMdvLy6RL1ZSxhC1VH/5yYIKnY05qTSmHX3hML4Uh7p6Fv4nd3KWsJg8Mcq9C7iTQsEV641aS8uUnV3dd81nkWVF8vCL+8t8OdZnsS7/EjrE/ZA62on0XhsjsTnX9TB2ZQ=
Received: from 30.221.129.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGXTr9V_1728353612)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 10:13:33 +0800
Message-ID: <b9565874-7018-46ef-b123-b524a1dffb21@linux.alibaba.com>
Date: Tue, 8 Oct 2024 10:13:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
To: Christian Brauner <brauner@kernel.org>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
 <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
 <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241007-zwietracht-flehen-1eeed6fac1a5@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2024/10/7 19:35, Christian Brauner wrote:
> On Sat, Oct 05, 2024 at 10:41:10PM GMT, Gao Xiang wrote:

...

>>
>> Hi Christian, if possible, could you give some other
>> idea to handle this case better? Many thanks!

Thanks for the reply!

> 
> (1) Require that the path be qualified like:
> 
>      fsconfig(<fd>, FSCONFIG_SET_STRING, "source", "file:/home/lis/src/mountcfs/cfs", 0)
> 
>      and match on it in either erofs_*_get_tree() or by adding a custom
>      function for the Opt_source/"source" parameter.

IMHO, Users could create names with the prefix `file:`,
it's somewhat strange to define a fixed prefix by the
definition of source path fc->source.

Although there could be some escape character likewise
way, but I'm not sure if it's worthwhile to work out
this in kernel.

> 
> (2) Add a erofs specific "source-file" mount option. IOW, check that
>      either "source-file" or "source" was specified but not both. You
>      could even set fc->source to "source-file" value and fail if
>      fc->source is already set. You get the idea.

I once thought to add a new mount option too, yet from
the user perpertive, I think users may not care about
the source type of an arbitary path, and the kernel also
can parse the type of the source path directly... so..


So.. I wonder if it's possible to add a new VFS interface
like get_tree_bdev_by_dev() for filesystems to specify a
device number rather than hardcoded hard-coded source path
way, e.g. I could see the potential benefits other than
the EROFS use case:

  - Filesystems can have other ways to get a bdev-based sb
    in addition to the current hard-coded source path way;

  - Some pseudo fs can use this way to generate a fs from a
    bdev.

  - Just like get_tree_nodev(), it doesn't strictly tie to
    fc->source too.

Also EROFS could lookup_bdev() (this kAPI is already
exported) itself to check if it uses get_tree_bdev_by_dev()
or get_tree_nodev()... Does it sounds good?  Many thanks!

Thanks,
Gao Xiang

diff --git a/fs/super.c b/fs/super.c
index 1db230432960..8cc8350b9ba6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1596,26 +1596,17 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
  EXPORT_SYMBOL_GPL(setup_bdev_super);
  
  /**
- * get_tree_bdev - Get a superblock based on a single block device
+ * get_tree_bdev_by_dev - Get a bdev-based superblock with a given device number
   * @fc: The filesystem context holding the parameters
   * @fill_super: Helper to initialise a new superblock
+ * @dev: The device number indicating the target block device
   */
-int get_tree_bdev(struct fs_context *fc,
+int get_tree_bdev_by_dev(struct fs_context *fc,
  		int (*fill_super)(struct super_block *,
-				  struct fs_context *))
+				  struct fs_context *), dev_t dev)
  {
  	struct super_block *s;
  	int error = 0;
-	dev_t dev;
-
-	if (!fc->source)
-		return invalf(fc, "No source specified");
-
-	error = lookup_bdev(fc->source, &dev);
-	if (error) {
-		errorf(fc, "%s: Can't lookup blockdev", fc->source);
-		return error;
-	}
  
  	fc->sb_flags |= SB_NOSEC;
  	s = sget_dev(fc, dev);
@@ -1644,6 +1635,30 @@ int get_tree_bdev(struct fs_context *fc,
  	fc->root = dget(s->s_root);
  	return 0;
  }
+EXPORT_SYMBOL_GPL(get_tree_bdev_by_dev);
+
+/**
+ * get_tree_bdev - Get a superblock based on a single block device
+ * @fc: The filesystem context holding the parameters
+ * @fill_super: Helper to initialise a new superblock
+ */
+int get_tree_bdev(struct fs_context *fc,
+		int (*fill_super)(struct super_block *,
+				  struct fs_context *))
+{
+	int error;
+	dev_t dev;
+
+	if (!fc->source)
+		return invalf(fc, "No source specified");
+
+	error = lookup_bdev(fc->source, &dev);
+	if (error) {
+		errorf(fc, "%s: Can't lookup blockdev", fc->source);
+		return error;
+	}
+	return get_tree_bdev_by_dev(fc, fill_super, dev);
+}
  EXPORT_SYMBOL(get_tree_bdev);
  
  static int test_bdev_super(struct super_block *s, void *data)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index c13e99cbbf81..54f23589ad5b 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -160,6 +160,9 @@ extern int get_tree_keyed(struct fs_context *fc,
  
  int setup_bdev_super(struct super_block *sb, int sb_flags,
  		struct fs_context *fc);
+int get_tree_bdev_by_dev(struct fs_context *fc,
+			 int (*fill_super)(struct super_block *sb,
+					   struct fs_context *fc), dev_t dev);
  extern int get_tree_bdev(struct fs_context *fc,
  			       int (*fill_super)(struct super_block *sb,
  						 struct fs_context *fc));


> 
> ?


