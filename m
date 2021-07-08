Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D33BFAD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 14:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhGHNCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 09:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230388AbhGHNCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625749189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDpg/gKTGwn8j2JOUyDKcJ07fjC4e5V637Yzj3ONXyo=;
        b=f7sF38rV+JFkOaFGciLQHqysbp/oD2kjHxktQAVr32x0OjaXWicy6JDIdrtUVqpWc/o0ko
        lFA9Kw87iV0ArnmuEjvX24E8VO7o+EdHzw8Oz1NPWNJvwRPC72gPJ6YnQZYn9j+VHj1Pw/
        YaT1a7dEW5JEMH42OqMII4k/oYC+mRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-LcLyaa_jPoybRPSOFiLUNw-1; Thu, 08 Jul 2021 08:59:46 -0400
X-MC-Unique: LcLyaa_jPoybRPSOFiLUNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2485100A954;
        Thu,  8 Jul 2021 12:59:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-175.rdu2.redhat.com [10.10.114.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CDB160843;
        Thu,  8 Jul 2021 12:59:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BB60922054F; Thu,  8 Jul 2021 08:59:36 -0400 (EDT)
Date:   Thu, 8 Jul 2021 08:59:36 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Virtio-fs] [PATCH 3/2] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <20210708125936.GA319010@redhat.com>
References: <20210621062657.3641879-1-hch@lst.de>
 <20210622081217.GA2975@lst.de>
 <YNGhERcnLuzjn8j9@stefanha-x1.localdomain>
 <20210629205048.GE5231@redhat.com>
 <20210630053601.GA29241@lst.de>
 <20210707210404.GB244500@redhat.com>
 <20210707210636.GC244500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707210636.GC244500@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 05:06:36PM -0400, Vivek Goyal wrote:
> On Wed, Jul 07, 2021 at 05:04:04PM -0400, Vivek Goyal wrote:
> > On Wed, Jun 30, 2021 at 07:36:01AM +0200, Christoph Hellwig wrote:
> > > On Tue, Jun 29, 2021 at 04:50:48PM -0400, Vivek Goyal wrote:
> > > > May be we should modify mount_block_root() code so that it does not
> > > > require that extra "\0". Possibly zero initialize page and that should
> > > > make sure list_bdev_fs_names() does not have to worry about it.
> > > > 
> > > > It is possible that a page gets full from the list of filesystems, and
> > > > last byte on page is terminating null. In that case just zeroing page
> > > > will not help. We can keep track of some sort of end pointer and make
> > > > sure we are not searching beyond that for valid filesystem types.
> > > > 
> > > > end = page + PAGE_SIZE - 1;
> > > > 
> > > > mount_block_root()
> > > > {
> > > > 	for (p = fs_names; p < end && *p; p += strlen(p)+1) {
> > > > 	}
> > > > }
> > > 
> > > Maybe.  To honest I'd prefer to not even touch this unrelated code given
> > > how full of landmines it is :)
> > 
> > Hi Christoph,
> > 
> > How about following patch. This applies on top of your patches. I noticed
> > that Al had suggested to return number of filesystems from helper
> > functions. I just did that and used that to iterate in the loop.
> > 
> > I tested it with a virtual block device (root=/dev/vda1) and it works.
> > I also filled page with garbage after allocation to make sure natually
> > occurring null is not there in the middle of page to terminate string.
> > 
> > If you like it, can you please incorporate it in your patches.
> 
> I noticed this will break with "root_fs_names=". Sorry, will have to
> fix split_fs_names() as well. Will do.

Hi Christoph,

I fixed it. Now both split_fs_names() and list_bdev_fs_names() return
count of fstype strings it placed in the buffer. And callers now
use that count to loop (instead of relying on extra null byte at the
end of the buffer).

I tested both nodev (virtiofs, 9p) and block dev rootfs (ext4) and
it works for me. Please have a look.

Thanks
Vivek


---
 fs/filesystems.c   |    5 ++++-
 include/linux/fs.h |    2 +-
 init/do_mounts.c   |   35 +++++++++++++++++++++++------------
 3 files changed, 28 insertions(+), 14 deletions(-)

Index: redhat-linux/fs/filesystems.c
===================================================================
--- redhat-linux.orig/fs/filesystems.c	2021-07-08 08:02:09.772766786 -0400
+++ redhat-linux/fs/filesystems.c	2021-07-08 08:02:12.044860918 -0400
@@ -209,10 +209,11 @@ SYSCALL_DEFINE3(sysfs, int, option, unsi
 }
 #endif
 
-void __init list_bdev_fs_names(char *buf, size_t size)
+int __init list_bdev_fs_names(char *buf, size_t size)
 {
 	struct file_system_type *p;
 	size_t len;
+	int count = 0;
 
 	read_lock(&file_systems_lock);
 	for (p = file_systems; p; p = p->next) {
@@ -226,8 +227,10 @@ void __init list_bdev_fs_names(char *buf
 		memcpy(buf, p->name, len);
 		buf += len;
 		size -= len;
+		count++;
 	}
 	read_unlock(&file_systems_lock);
+	return count;
 }
 
 #ifdef CONFIG_PROC_FS
Index: redhat-linux/include/linux/fs.h
===================================================================
--- redhat-linux.orig/include/linux/fs.h	2021-07-08 08:02:09.774766869 -0400
+++ redhat-linux/include/linux/fs.h	2021-07-08 08:02:12.046861001 -0400
@@ -3622,7 +3622,7 @@ int proc_nr_dentry(struct ctl_table *tab
 		  void *buffer, size_t *lenp, loff_t *ppos);
 int proc_nr_inodes(struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos);
-void __init list_bdev_fs_names(char *buf, size_t size);
+int __init list_bdev_fs_names(char *buf, size_t size);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
 #define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
Index: redhat-linux/init/do_mounts.c
===================================================================
--- redhat-linux.orig/init/do_mounts.c	2021-07-08 08:02:09.774766869 -0400
+++ redhat-linux/init/do_mounts.c	2021-07-08 08:02:12.046861001 -0400
@@ -338,14 +338,22 @@ __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
-static void __init split_fs_names(char *page, char *names)
+static int __init split_fs_names(char *page, char *names)
 {
-	strcpy(page, root_fs_names);
-	while (*page++) {
-		if (page[-1] == ',')
-			page[-1] = '\0';
+	int count = 0;
+	char *p = page;
+
+	strcpy(p, root_fs_names);
+	while (*p++) {
+		if (p[-1] == ',')
+			p[-1] = '\0';
 	}
-	*page = '\0';
+	*p = '\0';
+
+	for (p = page; *p; p += strlen(p)+1)
+		count++;
+
+	return count;
 }
 
 static int __init do_mount_root(const char *name, const char *fs,
@@ -391,15 +399,16 @@ void __init mount_block_root(char *name,
 	char *fs_names = page_address(page);
 	char *p;
 	char b[BDEVNAME_SIZE];
+	int num_fs, i;
 
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	if (root_fs_names)
-		split_fs_names(fs_names, root_fs_names);
+		num_fs = split_fs_names(fs_names, root_fs_names);
 	else
-		list_bdev_fs_names(fs_names, PAGE_SIZE);
+		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
 retry:
-	for (p = fs_names; *p; p += strlen(p)+1) {
+	for (p = fs_names, i = 0; i < num_fs; p += strlen(p)+1, i++) {
 		int err = do_mount_root(name, p, flags, root_mount_data);
 		switch (err) {
 			case 0:
@@ -432,7 +441,7 @@ retry:
 	printk("List of all partitions:\n");
 	printk_all_partitions();
 	printk("No filesystem could mount root, tried: ");
-	for (p = fs_names; *p; p += strlen(p)+1)
+	for (p = fs_names, i = 0; i < num_fs; p += strlen(p)+1, i++)
 		printk(" %s", p);
 	printk("\n");
 	panic("VFS: Unable to mount root fs on %s", b);
@@ -533,13 +542,15 @@ static int __init mount_nodev_root(void)
 {
 	char *fs_names, *fstype;
 	int err = -EINVAL;
+	int num_fs, i;
 
 	fs_names = (void *)__get_free_page(GFP_KERNEL);
 	if (!fs_names)
 		return -EINVAL;
-	split_fs_names(fs_names, root_fs_names);
+	num_fs = split_fs_names(fs_names, root_fs_names);
 
-	for (fstype = fs_names; *fstype; fstype += strlen(fstype) + 1) {
+	for (fstype = fs_names, i = 0; i < num_fs;
+	     fstype += strlen(fstype) + 1, i++) {
 		if (!fs_is_nodev(fstype))
 			continue;
 		err = do_mount_root(root_device_name, fstype, root_mountflags,

