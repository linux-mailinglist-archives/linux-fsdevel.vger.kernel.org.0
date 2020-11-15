Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C482B39B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 22:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgKOVl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 16:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKOVl4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 16:41:56 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974E6C0613CF;
        Sun, 15 Nov 2020 13:41:30 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id g11so7112340pll.13;
        Sun, 15 Nov 2020 13:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A++4K5J7hIaIMEGL2cmJWcX6n1X047O09HNdxLFMGbM=;
        b=mw+Jt/hJ03srIHk05fDHwZkDCLPTw/TMIwvJpm9mJ9OvEoCWuG0Wvj4pkMre/Q2xCA
         UJ/1LIKf03BbDwCFNWEqKYab/Bi1gmoh+X7AbZCprcwQDkzV1NDkxZvlC+p3jNkYPlFZ
         o0YSdmBHqowlAsYmle0kqHUQH+iRYTct+YsGpQVVLmOoMqHSUrCkRNJReCSU74GOngrf
         gmF7q3a2LfW+fHAkYwiYBLjn3G+harH5S5tIEk9Y7dPcsPDVB9rCG9jbHScklmzGby5h
         5EyRmn99CMFXkFqpOaQ7yOea4Y3+BogK8mjYhjWUf6LCp5mJCcaI4Kkn7UIrsBlx3pLu
         aIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A++4K5J7hIaIMEGL2cmJWcX6n1X047O09HNdxLFMGbM=;
        b=eDSfHcR2YsC1+xy2EFwdwI+fS2m5L+wPf12bA99bv8nMRypoiMrv/fsIWypJ7R1ipj
         5MXegrQRveoOIppCnroMsRqTLt6aALAANqbkmlKBCJGQUbEnKayEqBGyPAhYMKqNZMag
         ph1gtSZBfQ9zLdKSa3RLpHh/PwoyY/5Rq3fceSGPiPQywRwwGlA7veM3qEE4XA2GXoDo
         ye53t4oze8ALTDZJoLtuE3F+P59PAeJSQCSl+kKW5aY6vvhC1PxR0HRC/Q4KkAo7/41o
         5RV0uviHdNm1aCZx5HOMEp8PDDBg8gi960BKBDtsRC2KwVmLwTULlvJRAD5+HsxjKlnK
         2ikQ==
X-Gm-Message-State: AOAM532Qv/5F7jMqSbm8EMfXQxz7W69yTu4qBLmWGqrS0siTXoT20y8q
        kMnIBbVYYm5eZ/MVUMF7LCQ=
X-Google-Smtp-Source: ABdhPJz9QfISyCUzgGBLryE5agZtqoIBvjeYBOIl06FCgwPTklnd20IxCLTfqcHb3wpMN1rpCz/8FQ==
X-Received: by 2002:a17:902:c404:b029:d6:b050:bac0 with SMTP id k4-20020a170902c404b02900d6b050bac0mr10365505plk.61.1605476489648;
        Sun, 15 Nov 2020 13:41:29 -0800 (PST)
Received: from Ryzen-9-3900X.localdomain (ip68-98-75-144.ph.ph.cox.net. [68.98.75.144])
        by smtp.gmail.com with ESMTPSA id y5sm7699723pja.52.2020.11.15.13.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:41:28 -0800 (PST)
Date:   Sun, 15 Nov 2020 14:41:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201115214125.GA317@Ryzen-9-3900X.localdomain>
References: <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk>
 <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk>
 <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk>
 <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk>
 <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20201115155355.GR3576660@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Al,

Apologies for the delay.

On Sun, Nov 15, 2020 at 03:53:55PM +0000, Al Viro wrote:
> On Sat, Nov 14, 2020 at 08:50:00PM +0000, Al Viro wrote:
> 
> OK, I think I understand what's going on.  Could you check if
> reverting the variant in -next and applying the following instead
> fixes what you are seeing?

The below diff on top of d4d50710a8b46082224376ef119a4dbb75b25c56 does
not fix my issue unfortunately.

> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 3b20e21604e7..35667112bbd1 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -168,7 +168,6 @@ EXPORT_SYMBOL(seq_read);
>  ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct seq_file *m = iocb->ki_filp->private_data;
> -	size_t size = iov_iter_count(iter);
>  	size_t copied = 0;
>  	size_t n;
>  	void *p;
> @@ -208,16 +207,15 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	}
>  	/* if not empty - flush it first */
>  	if (m->count) {
> -		n = min(m->count, size);
> -		if (copy_to_iter(m->buf + m->from, n, iter) != n)
> -			goto Efault;
> +		n = copy_to_iter(m->buf + m->from, m->count, iter);
>  		m->count -= n;
>  		m->from += n;
> -		size -= n;
>  		copied += n;
> -		if (!size)
> -			goto Done;
> +		if (m->count)
> +			goto Efault;
>  	}
> +	if (!iov_iter_count(iter))
> +		goto Done;
>  	/* we need at least one record in buffer */
>  	m->from = 0;
>  	p = m->op->start(m, &m->index);
> @@ -249,6 +247,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	goto Done;
>  Fill:
>  	/* they want more? let's try to get some more */
> +	/* m->count is positive and there's space left in iter */
>  	while (1) {
>  		size_t offs = m->count;
>  		loff_t pos = m->index;
> @@ -263,7 +262,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  			err = PTR_ERR(p);
>  			break;
>  		}
> -		if (m->count >= size)
> +		if (m->count >= iov_iter_count(iter))
>  			break;
>  		err = m->op->show(m, p);
>  		if (seq_has_overflowed(m) || err) {
> @@ -273,12 +272,12 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		}
>  	}
>  	m->op->stop(m, p);
> -	n = min(m->count, size);
> -	if (copy_to_iter(m->buf, n, iter) != n)
> -		goto Efault;
> +	n = copy_to_iter(m->buf, m->count, iter);
>  	copied += n;
> -	m->count -= n;
>  	m->from = n;
> +	m->count -= n;
> +	if (m->count)
> +		goto Efault;
>  Done:
>  	if (!copied)
>  		copied = err;
> 

Replying to your two other messages here:

> FWIW, just to make sure:
> 	1) does reverting just that commit recover the desired behaviour?

Yes, d4d50710a8b46082224376ef119a4dbb75b25c56 is fine,
6a9f696d1627bacc91d1cebcfb177f474484e8ba is broken.

$ uname -r
5.10.0-rc2-microsoft-00001-gd4d50710a8b4

$ echo $PATH
/home/nathan/usr/bin:/home/nathan/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/mnt/c/Windows/system32:...

$ uname -r
5.10.0-rc2-microsoft-00002-g6a9f696d1627

$ echo $PATH
/home/nathan/usr/bin:/home/nathan/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

> 	2) could you verify that your latest tests had been done with
> the incremental I'd posted (shifting the if (....) goto Done; out of the if
> body)?
> 	3) does the build with that commit reverted produce any warnings
> related to mountinfo?

d4d50710a8b46082224376ef119a4dbb75b25c56:

$ dmesg -l err
[    0.064825] PCI: Fatal: No config space access function found
[    0.077436] kvm: no hardware support
[    0.077438] kvm: no hardware support
[    0.108227] hv_utils: cannot register PTP clock: 0
[    2.518229] FS-Cache: Duplicate cookie detected
[    2.518232] FS-Cache: O-cookie c=000000005d51d0cd [p=000000006bb17fa6 fl=222 nc=0 na=1]
[    2.518232] FS-Cache: O-cookie d=0000000021f3f873 n=000000002fb0c46e
[    2.518233] FS-Cache: O-key=[10] '34323934393337353435'
[    2.518236] FS-Cache: N-cookie c=000000002e0fa15c [p=000000006bb17fa6 fl=2 nc=0 na=1]
[    2.518236] FS-Cache: N-cookie d=0000000021f3f873 n=00000000a3943d77
[    2.518236] FS-Cache: N-key=[10] '34323934393337353435'

6a9f696d1627bacc91d1cebcfb177f474484e8ba:

$ dmesg -l err
[    0.064266] PCI: Fatal: No config space access function found
[    0.077833] kvm: no hardware support
[    0.077835] kvm: no hardware support
[    0.107284] hv_utils: cannot register PTP clock: 0
[    0.221703] init: (235) ERROR: LogException:36: LOCALHOST: Could not start localhost port scanner.
[    2.428629] FS-Cache: Duplicate cookie detected
[    2.428631] FS-Cache: O-cookie c=000000008dc18c92 [p=00000000e8a82afe fl=222 nc=0 na=1]
[    2.428631] FS-Cache: O-cookie d=000000007254ca01 n=0000000009bd1860
[    2.428632] FS-Cache: O-key=[10] '34323934393337353336'
[    2.428635] FS-Cache: N-cookie c=000000005941e9ee [p=00000000e8a82afe fl=2 nc=0 na=1]
[    2.428635] FS-Cache: N-cookie d=000000007254ca01 n=0000000095ef7a9f
[    2.428636] FS-Cache: N-key=[10] '34323934393337353336'
[    2.438529] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.438535] init: (9) ERROR: CreateProcessParseCommon:849: Failed to translate C:\Users\natec
[    2.438550] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.438552] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows\system32
[    2.438558] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.438559] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows
[    2.438565] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14

6a9f696d1627bacc91d1cebcfb177f474484e8ba + shifting the if (....) goto Done; out of the if body:

$ echo $PATH
/home/nathan/usr/bin:/home/nathan/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

$ dmesg -l err
[    0.059315] PCI: Fatal: No config space access function found
[    0.077335] kvm: no hardware support
[    0.077336] kvm: no hardware support
[    0.107422] hv_utils: cannot register PTP clock: 0
[    2.437321] FS-Cache: Duplicate cookie detected
[    2.437323] FS-Cache: O-cookie c=0000000061ae161f [p=000000005e0c26a4 fl=222 nc=0 na=1]
[    2.437323] FS-Cache: O-cookie d=000000006e487749 n=00000000d6f2b7cc
[    2.437324] FS-Cache: O-key=[10] '34323934393337353337'
[    2.437327] FS-Cache: N-cookie c=00000000c08b3ba9 [p=000000005e0c26a4 fl=2 nc=0 na=1]
[    2.437327] FS-Cache: N-cookie d=000000006e487749 n=0000000026c46bbc
[    2.437328] FS-Cache: N-key=[10] '34323934393337353337'
[    2.447874] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.447878] init: (9) ERROR: CreateProcessParseCommon:849: Failed to translate C:\Users\natec
[    2.447905] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.447906] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows\system32
[    2.447923] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.447924] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows
[    2.447940] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14

Your latest diff on top of d4d50710a8b46082224376ef119a4dbb75b25c56:

$ echo $PATH
/home/nathan/usr/bin:/home/nathan/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

$ dmesg -l err
[    0.064514] PCI: Fatal: No config space access function found
[    0.078288] kvm: no hardware support
[    0.078290] kvm: no hardware support
[    0.108100] hv_utils: cannot register PTP clock: 0
[    2.428126] FS-Cache: Duplicate cookie detected
[    2.428128] FS-Cache: O-cookie c=00000000f90a28fc [p=000000008eaf59d5 fl=222 nc=0 na=1]
[    2.428128] FS-Cache: O-cookie d=00000000e1e04d39 n=00000000109665e8
[    2.428129] FS-Cache: O-key=[10] '34323934393337353336'
[    2.428132] FS-Cache: N-cookie c=00000000c32f0eb9 [p=000000008eaf59d5 fl=2 nc=0 na=1]
[    2.428132] FS-Cache: N-cookie d=00000000e1e04d39 n=000000003fef461f
[    2.428132] FS-Cache: N-key=[10] '34323934393337353336'
[    2.439541] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.439545] init: (9) ERROR: CreateProcessParseCommon:849: Failed to translate C:\Users\natec
[    2.439571] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.439573] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows\system32
[    2.439590] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.439591] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows
[    2.439607] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14

> 	4) your posted log with WARN_ON unfortunately starts *after*
> the mountinfo accesses; could you check which process had been doing those?
> The Comm: ... part in there, that is.

init it looks like. Attached is the output of

---
diff --git a/fs/read_write.c b/fs/read_write.c
index 75f764b43418..37708555cb8d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -757,6 +757,10 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
                struct iovec iovec = iov_iter_iovec(iter);
                ssize_t nr;

+               if (unlikely(!memcmp(filp->f_path.dentry->d_name.name, "mountinfo", 10)) &&
+                   WARN_ON(!iovec.iov_len))
+                       printk(KERN_ERR "odd readv on %pd4\n", filp);
+
                if (type == READ) {
                        nr = filp->f_op->read(filp, iovec.iov_base,
                                              iovec.iov_len, ppos);
---

against your latest diff on top of d4d50710a8b46082224376ef119a4dbb75b25c56.

> 	5) in the "I don't believe that could happen, but let's make sure"
> department: turn the
>         /* m->count is positive and there's space left in iter */
> comment in seq_read_iter() into an outright
> 	BUG_ON(!m->count || !iov_iter_count(iter));

Does not look like it triggers against your latest diff.

> OK, so let's do this: fix in seq_read_iter() + in do_loop_readv_writev()
> (on entry) the following (racy as hell, but will do for debugging):
> 
> 	bool weird = false;
> 
> 	if (unlikely(memcmp(file->f_path.dentry->d_name.name, "mountinfo", 10))) {
> 		int i;
> 
> 		for (i = 0; i < iter->nr_segs; i++)
> 			if (!iter->iov[i].iov_len)
> 				weird = true;
> 		if (weird) {
> 			printk(KERN_ERR "[%s]: weird readv on %p4D (%ld) ",
> 				current->comm, filp, (long)filp->f_pos);
> 			for (i = 0; i < iter->nr_segs; i++)
> 				printk(KERN_CONT "%c%zd", i ? ':' : '<',
> 					iter->iov[i].iov_len);
> 			printk(KERN_CONT "> ");
> 		}
> 	}
> and in the end (just before return)
> 	if (weird)
> 		printk(KERN_CONT "-> %zd\n", ret);
> 
> Preferably along with the results of cat /proc/<whatever it is>/mountinfo both
> on that and on the working kernel...

I applied this against your latest diff, attached as weird_readv.

Good (d4d50710a8b46082224376ef119a4dbb75b25c56):

$ cat /proc/9/mountinfo
29 21 8:0 / / rw,relatime - ext4 /dev/sda rw,discard,no_fc,errors=remount-ro,data=ordered
30 29 0:15 / /mnt/wsl rw,relatime shared:1 - tmpfs tmpfs rw
31 29 0:16 /init /init ro,relatime - 9p tools ro,dirsync,aname=tools;fmask=022,loose,access=client,trans=fd,rfd=6,wfd=6
32 29 0:5 / /dev rw,nosuid,relatime - devtmpfs none rw,size=8176740k,nr_inodes=2044185,mode=755
33 29 0:14 / /sys rw,nosuid,nodev,noexec,noatime - sysfs sysfs rw
34 29 0:19 / /proc rw,nosuid,nodev,noexec,noatime - proc proc rw
35 32 0:20 / /dev/pts rw,nosuid,noexec,noatime - devpts devpts rw,gid=5,mode=620,ptmxmode=000
36 29 0:21 / /run rw,nosuid,noexec,noatime - tmpfs none rw,mode=755
37 36 0:22 / /run/lock rw,nosuid,nodev,noexec,noatime - tmpfs none rw
38 36 0:23 / /run/shm rw,nosuid,nodev,noatime - tmpfs none rw
39 36 0:24 / /run/user rw,nosuid,nodev,noexec,noatime - tmpfs none rw,mode=755
40 34 0:17 / /proc/sys/fs/binfmt_misc rw,relatime - binfmt_misc binfmt_misc rw
41 33 0:25 / /sys/fs/cgroup rw,nosuid,nodev,noexec,relatime - tmpfs tmpfs rw,mode=755
42 41 0:26 / /sys/fs/cgroup/unified rw,nosuid,nodev,noexec,relatime - cgroup2 cgroup2 rw,nsdelegate
43 41 0:27 / /sys/fs/cgroup/cpuset rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,cpuset
44 41 0:28 / /sys/fs/cgroup/cpu rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,cpu
45 41 0:29 / /sys/fs/cgroup/cpuacct rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,cpuacct
46 41 0:30 / /sys/fs/cgroup/blkio rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,blkio
47 41 0:31 / /sys/fs/cgroup/memory rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,memory
48 41 0:32 / /sys/fs/cgroup/devices rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,devices
49 41 0:33 / /sys/fs/cgroup/freezer rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,freezer
50 41 0:34 / /sys/fs/cgroup/net_cls rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,net_cls
51 41 0:35 / /sys/fs/cgroup/perf_event rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,perf_event
52 41 0:36 / /sys/fs/cgroup/net_prio rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,net_prio
53 41 0:37 / /sys/fs/cgroup/hugetlb rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,hugetlb
54 41 0:38 / /sys/fs/cgroup/pids rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,pids
55 41 0:39 / /sys/fs/cgroup/rdma rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,rdma
90 29 0:40 / /mnt/c rw,noatime - 9p C:\134 rw,dirsync,aname=drvfs;path=C:\;uid=1000;gid=1000;symlinkroot=/mnt/,mmap,access=client,msize=65536,trans=fd,rfd=8,wfd=8
91 29 0:41 / /mnt/d rw,noatime - 9p D:\134 rw,dirsync,aname=drvfs;path=D:\;uid=1000;gid=1000;symlinkroot=/mnt/,mmap,access=client,msize=65536,trans=fd,rfd=8,wfd=8

Bad (your latest diff on top of d4d50710a8b46082224376ef119a4dbb75b25c56

$ cat /proc/9/mountinfo
29 21 8:0 / / rw,relatime - ext4 /dev/sda rw,discard,no_fc,errors=remount-ro,data=ordered
30 29 0:15 / /mnt/wsl rw,relatime shared:1 - tmpfs tmpfs rw
31 29 0:16 /init /init ro,relatime - 9p tools ro,dirsync,aname=tools;fmask=022,loose,access=client,trans=fd,rfd=6,wfd=6
32 29 0:5 / /dev rw,nosuid,relatime - devtmpfs none rw,size=8176740k,nr_inodes=2044185,mode=755
33 29 0:14 / /sys rw,nosuid,nodev,noexec,noatime - sysfs sysfs rw
34 29 0:19 / /proc rw,nosuid,nodev,noexec,noatime - proc proc rw
35 32 0:20 / /dev/pts rw,nosuid,noexec,noatime - devpts devpts rw,gid=5,mode=620,ptmxmode=000
36 29 0:21 / /run rw,nosuid,noexec,noatime - tmpfs none rw,mode=755
37 36 0:22 / /run/lock rw,nosuid,nodev,noexec,noatime - tmpfs none rw
38 36 0:23 / /run/shm rw,nosuid,nodev,noatime - tmpfs none rw
39 36 0:24 / /run/user rw,nosuid,nodev,noexec,noatime - tmpfs none rw,mode=755
40 34 0:17 / /proc/sys/fs/binfmt_misc rw,relatime - binfmt_misc binfmt_misc rw
41 33 0:25 / /sys/fs/cgroup rw,nosuid,nodev,noexec,relatime - tmpfs tmpfs rw,mode=755
42 41 0:26 / /sys/fs/cgroup/unified rw,nosuid,nodev,noexec,relatime - cgroup2 cgroup2 rw,nsdelegate
43 41 0:27 / /sys/fs/cgroup/cpuset rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,cpuset
44 41 0:28 / /sys/fs/cgroup/cpu rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,cpu
45 41 0:29 / /sys/fs/cgroup/cpuacct rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,cpuacct
46 41 0:30 / /sys/fs/cgroup/blkio rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,blkio
47 41 0:31 / /sys/fs/cgroup/memory rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,memory
48 41 0:32 / /sys/fs/cgroup/devices rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,devices
49 41 0:33 / /sys/fs/cgroup/freezer rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,freezer
50 41 0:34 / /sys/fs/cgroup/net_cls rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,net_cls
51 41 0:35 / /sys/fs/cgroup/perf_event rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,perf_event
52 41 0:36 / /sys/fs/cgroup/net_prio rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,net_prio
53 41 0:37 / /sys/fs/cgroup/hugetlb rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,hugetlb
54 41 0:38 / /sys/fs/cgroup/pids rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,pids
55 41 0:39 / /sys/fs/cgroup/rdma rw,nosuid,nodev,noexec,relatime - cgroup cgroup rw,rdma
90 29 0:40 / /mnt/c rw,noatime - 9p C:\134 rw,dirsync,aname=drvfs;path=C:\;uid=1000;gid=1000;symlinkroot=/mnt/,mmap,access=client,msize=65536,trans=fd,rfd=8,wfd=8
91 29 0:41 / /mnt/d rw,noatime - 9p D:\134 rw,dirsync,aname=drvfs;path=D:\;uid=1000;gid=1000;symlinkroot=/mnt/,mmap,access=client,msize=65536,trans=fd,rfd=8,wfd=8

If you need any more information, please let me know!

Cheers,
Nathan

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="dmesg_warn_on_mountinfo_filtered.txt"

[    0.000000] Linux version 5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty (nathan@Ryzen-9-3900X) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #10 SMP Sun Nov 15 14:23:57 MST 2020
[    0.000000] Kernel is locked down from Kernel configuration; see man kernel_lockdown.7
[    0.000000] Command line: initrd=\initrd.img panic=-1 pty.legacy_count=0 nr_cpus=24
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000e0fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000001fffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000000200000-0x00000000f7ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000407ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI not present or invalid.
[    0.000000] Hypervisor detected: Microsoft Hyper-V
[    0.000000] Hyper-V: features 0xae7f, hints 0xc2c, misc 0x20bed7b2
[    0.000000] Hyper-V Host Build:19041-10.0-0-0.630
[    0.000000] Hyper-V: LAPIC Timer Frequency: 0x1e8480
[    0.000000] Hyper-V: Using hypercall for remote TLB flush
[    0.000000] clocksource: hyperv_clocksource_tsc_page: mask: 0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000001] tsc: Detected 3800.009 MHz processor
[    0.000005] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000006] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000008] last_pfn = 0x408000 max_arch_pfn = 0x400000000
[    0.000028] MTRR default type: uncachable
[    0.000028] MTRR fixed ranges disabled:
[    0.000029]   00000-FFFFF uncachable
[    0.000029] MTRR variable ranges disabled:
[    0.000029]   0 disabled
[    0.000029]   1 disabled
[    0.000030]   2 disabled
[    0.000030]   3 disabled
[    0.000030]   4 disabled
[    0.000030]   5 disabled
[    0.000030]   6 disabled
[    0.000031]   7 disabled
[    0.000031] Disabled
[    0.000031] x86/PAT: MTRRs disabled, skipping PAT initialization too.
[    0.000037] CPU MTRRs all blank - virtualized system.
[    0.000038] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000039] last_pfn = 0xf8000 max_arch_pfn = 0x400000000
[    0.000048] Using GB pages for direct mapping
[    0.000100] RAMDISK: [mem 0x02f70000-0x02f7ffff]
[    0.000102] ACPI: Early table checksum verification disabled
[    0.000103] ACPI: RSDP 0x00000000000E0000 000024 (v02 VRTUAL)
[    0.000105] ACPI: XSDT 0x0000000000100000 000044 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000108] ACPI: FACP 0x0000000000101000 000114 (v06 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000110] ACPI: DSDT 0x00000000001011B8 01E184 (v02 MSFTVM DSDT01   00000001 MSFT 05000000)
[    0.000112] ACPI: FACS 0x0000000000101114 000040
[    0.000113] ACPI: OEM0 0x0000000000101154 000064 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000114] ACPI: SRAT 0x000000000011F33C 000390 (v02 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000116] ACPI: APIC 0x000000000011F6CC 000108 (v04 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000118] ACPI: Local APIC address 0xfee00000
[    0.000299] Zone ranges:
[    0.000300]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000301]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000301]   Normal   [mem 0x0000000100000000-0x0000000407ffffff]
[    0.000302] Movable zone start for each node
[    0.000302] Early memory node ranges
[    0.000303]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.000303]   node   0: [mem 0x0000000000200000-0x00000000f7ffffff]
[    0.000304]   node   0: [mem 0x0000000100000000-0x0000000407ffffff]
[    0.000448] Zeroed struct page in unavailable ranges: 353 pages
[    0.000449] Initmem setup node 0 [mem 0x0000000000001000-0x0000000407ffffff]
[    0.000450] On node 0 totalpages: 4193951
[    0.000451]   DMA zone: 59 pages used for memmap
[    0.000451]   DMA zone: 22 pages reserved
[    0.000452]   DMA zone: 3743 pages, LIFO batch:0
[    0.000467]   DMA32 zone: 16320 pages used for memmap
[    0.000468]   DMA32 zone: 1011712 pages, LIFO batch:63
[    0.009339]   Normal zone: 49664 pages used for memmap
[    0.009341]   Normal zone: 3178496 pages, LIFO batch:63
[    0.009675] ACPI: Local APIC address 0xfee00000
[    0.009680] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.009965] IOAPIC[0]: apic_id 24, version 17, address 0xfec00000, GSI 0-23
[    0.009968] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.009969] ACPI: IRQ9 used by override.
[    0.009970] Using ACPI (MADT) for SMP configuration information
[    0.009975] smpboot: Allowing 24 CPUs, 0 hotplug CPUs
[    0.009983] [mem 0xf8000000-0xffffffff] available for PCI devices
[    0.009983] Booting paravirtualized kernel on Hyper-V
[    0.009984] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.013232] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:24 nr_node_ids:1
[    0.014134] percpu: Embedded 41 pages/cpu s135192 r0 d32744 u262144
[    0.014138] pcpu-alloc: s135192 r0 d32744 u262144 alloc=1*2097152
[    0.014139] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.014143] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 
[    0.014152] Built 1 zonelists, mobility grouping on.  Total pages: 4127886
[    0.014153] Kernel command line: initrd=\initrd.img panic=-1 pty.legacy_count=0 nr_cpus=24
[    0.014183] printk: log_buf_len individual max cpu contribution: 262144 bytes
[    0.014183] printk: log_buf_len total cpu_extra contributions: 6029312 bytes
[    0.014184] printk: log_buf_len min size: 262144 bytes
[    0.022373] printk: log_buf_len: 8388608 bytes
[    0.022375] printk: early log buf free: 256264(97%)
[    0.024821] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.025886] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.025950] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.040784] Memory: 4126944K/16775804K available (14341K kernel code, 1480K rwdata, 2448K rodata, 916K init, 1484K bss, 422372K reserved, 0K cma-reserved)
[    0.040789] random: get_random_u64 called from __kmem_cache_create+0x29/0x3b0 with crng_init=0
[    0.040871] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=1
[    0.041084] rcu: Hierarchical RCU implementation.
[    0.041086] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=24.
[    0.041087] 	Tracing variant of Tasks RCU enabled.
[    0.041087] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.041087] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=24
[    0.041095] Using NULL legacy PIC
[    0.041096] NR_IRQS: 16640, nr_irqs: 616, preallocated irqs: 0
[    0.041445] random: crng done (trusting CPU's manufacturer)
[    0.041472] printk: console [ttyS0] enabled
[    0.041477] ACPI: Core revision 20200925
[    0.041570] Failed to register legacy timer interrupt
[    0.041571] APIC: Switch to symmetric I/O mode setup
[    0.041572] Switched APIC routing to physical flat.
[    0.041591] Hyper-V: Using IPI hypercalls
[    0.041591] Hyper-V: Using enlightened APIC (xapic mode)
[    0.041661] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6d8cc2767c9, max_idle_ns: 881590832756 ns
[    0.041663] Calibrating delay loop (skipped), value calculated using timer frequency.. 7600.01 BogoMIPS (lpj=38000090)
[    0.041665] pid_max: default: 32768 minimum: 301
[    0.041687] LSM: Security Framework initializing
[    0.041689] Yama: becoming mindful.
[    0.041692] LoadPin: ready to pin (currently enforcing)
[    0.041718] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.041734] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.041954] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.041971] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.041971] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.041973] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.041974] Spectre V2 : Mitigation: Full AMD retpoline
[    0.041974] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.041975] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.041975] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.041976] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.042082] Freeing SMP alternatives memory: 48K
[    0.042122] smpboot: CPU0: AMD Ryzen 9 3900X 12-Core Processor (family: 0x17, model: 0x71, stepping: 0x0)
[    0.042166] Performance Events: PMU not available due to virtualization, using software events only.
[    0.042265] rcu: Hierarchical SRCU implementation.
[    0.042522] smp: Bringing up secondary CPUs ...
[    0.042554] x86: Booting SMP configuration:
[    0.042555] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.052168] smp: Brought up 1 node, 24 CPUs
[    0.052168] smpboot: Max logical packages: 1
[    0.052168] smpboot: Total of 24 processors activated (182400.43 BogoMIPS)
[    0.065457] node 0 deferred pages initialised in 10ms
[    0.069109] devtmpfs: initialized
[    0.069109] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.069109] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.071783] NET: Registered protocol family 16
[    0.071957] ACPI: bus type PCI registered
[    0.071957] PCI: Fatal: No config space access function found
[    0.072580] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.072580] raid6: skip pq benchmark and using algorithm avx2x4
[    0.072580] raid6: using avx2x2 recovery algorithm
[    0.072580] ACPI: Added _OSI(Module Device)
[    0.072580] ACPI: Added _OSI(Processor Device)
[    0.072580] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.072580] ACPI: Added _OSI(Processor Aggregator Device)
[    0.072580] ACPI: Added _OSI(Linux-Dell-Video)
[    0.072580] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.072580] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.081942] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.082680] ACPI: Interpreter enabled
[    0.082683] ACPI: (supports S0 S5)
[    0.082684] ACPI: Using IOAPIC for interrupt routing
[    0.082690] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.082827] ACPI: Enabled 1 GPEs in block 00 to 0F
[    0.083887] iommu: Default domain type: Translated 
[    0.083951] SCSI subsystem initialized
[    0.084036] hv_vmbus: Vmbus version:5.2
[    0.084036] PCI: Using ACPI for IRQ routing
[    0.084036] PCI: System does not support PCI
[    0.084036] clocksource: Switched to clocksource tsc-early
[    0.084036] hv_vmbus: Unknown GUID: c376c1c3-d276-48d2-90a9-c04748072c60
[    0.084036] VFS: Disk quotas dquot_6.6.0
[    0.084036] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.084036] FS-Cache: Loaded
[    0.084036] pnp: PnP ACPI init
[    0.084036] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.084036] pnp: PnP ACPI: found 1 devices
[    0.084036] NET: Registered protocol family 2
[    0.084036] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.084036] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.084036] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.084036] TCP: Hash tables configured (established 131072 bind 65536)
[    0.084036] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.084036] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.084036] NET: Registered protocol family 1
[    0.084036] RPC: Registered named UNIX socket transport module.
[    0.084036] RPC: Registered udp transport module.
[    0.084036] RPC: Registered tcp transport module.
[    0.084036] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.084036] PCI: CLS 0 bytes, default 64
[    0.084036] Trying to unpack rootfs image as initramfs...
[    0.084036] Freeing initrd memory: 64K
[    0.084036] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.084036] software IO TLB: mapped [mem 0x00000000f4000000-0x00000000f8000000] (64MB)
[    0.085373] kvm: no hardware support
[    0.085375] has_svm: svm not available
[    0.085375] kvm: no hardware support
[    0.087760] Initialise system trusted keyrings
[    0.087845] workingset: timestamp_bits=46 max_order=22 bucket_order=0
[    0.088635] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.089090] NFS: Registering the id_resolver key type
[    0.089096] Key type id_resolver registered
[    0.089096] Key type id_legacy registered
[    0.089097] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    0.090790] Key type cifs.idmap registered
[    0.090838] fuse: init (API version 7.32)
[    0.090963] SGI XFS with ACLs, security attributes, realtime, scrub, repair, quota, no debug enabled
[    0.092385] 9p: Installing v9fs 9p2000 file system support
[    0.092393] FS-Cache: Netfs '9p' registered for caching
[    0.092551] FS-Cache: Netfs 'ceph' registered for caching
[    0.092554] ceph: loaded (mds proto 32)
[    0.095029] NET: Registered protocol family 38
[    0.095030] xor: automatically using best checksumming function   avx       
[    0.095031] Key type asymmetric registered
[    0.095031] Asymmetric key parser 'x509' registered
[    0.095036] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.095928] hv_vmbus: registering driver hv_pci
[    0.096126] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.096392] Non-volatile memory driver v1.3
[    0.099390] brd: module loaded
[    0.100261] loop: module loaded
[    0.100541] hv_vmbus: registering driver hv_storvsc
[    0.100841] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
[    0.100841] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[    0.100852] tun: Universal TUN/TAP device driver, 1.6
[    0.101032] PPP generic driver version 2.4.2
[    0.101136] PPP BSD Compression module registered
[    0.101136] PPP Deflate Compression module registered
[    0.101138] PPP MPPE Compression module registered
[    0.101139] NET: Registered protocol family 24
[    0.101142] hv_vmbus: registering driver hv_netvsc
[    0.101600] scsi host0: storvsc_host_t
[    0.112872] VFIO - User Level meta-driver version: 0.3
[    0.113203] hv_vmbus: registering driver hyperv_keyboard
[    0.113449] rtc_cmos 00:00: RTC can wake from S4
[    0.114605] rtc_cmos 00:00: registered as rtc0
[    0.114922] rtc_cmos 00:00: setting system clock to 2020-11-15T21:24:09 UTC (1605475449)
[    0.114932] rtc_cmos 00:00: alarms up to one month, 114 bytes nvram
[    0.115052] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
[    0.115513] hv_utils: Registering HyperV Utility Driver
[    0.115514] hv_vmbus: registering driver hv_utils
[    0.115536] hv_vmbus: registering driver hv_balloon
[    0.115540] hv_utils: cannot register PTP clock: 0
[    0.115784] hv_utils: TimeSync IC version 4.0
[    0.115885] hv_balloon: Using Dynamic Memory protocol version 2.0
[    0.116976] Mirror/redirect action on
[    0.117292] IPVS: Registered protocols (TCP, UDP)
[    0.117302] IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
[    0.117323] IPVS: ipvs loaded.
[    0.117323] IPVS: [rr] scheduler registered.
[    0.117324] IPVS: [wrr] scheduler registered.
[    0.117324] IPVS: [sh] scheduler registered.
[    0.118956] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[    0.119481] Initializing XFRM netlink socket
[    0.119537] NET: Registered protocol family 10
[    0.120045] Segment Routing with IPv6
[    0.121342] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.121403] NET: Registered protocol family 17
[    0.121416] Bridge firewalling registered
[    0.121421] 8021q: 802.1Q VLAN Support v1.8
[    0.121438] sctp: Hash tables configured (bind 256/256)
[    0.121640] 9pnet: Installing 9P2000 support
[    0.121650] Key type dns_resolver registered
[    0.121650] Key type ceph registered
[    0.122055] libceph: loaded (mon/osd proto 15/24)
[    0.122110] NET: Registered protocol family 40
[    0.122111] hv_vmbus: registering driver hv_sock
[    0.122411] IPI shorthand broadcast: enabled
[    0.122414] sched_clock: Marking stable (121792240, 305100)->(127081600, -4984260)
[    0.122659] registered taskstats version 1
[    0.122660] Loading compiled-in X.509 certificates
[    0.122686] Key type ._fscrypt registered
[    0.122687] Key type .fscrypt registered
[    0.122687] Key type fscrypt-provisioning registered
[    0.122881] Btrfs loaded, crc32c=crc32c-generic
[    0.123556] Freeing unused kernel image (initmem) memory: 916K
[    0.181758] Write protecting the kernel read-only data: 20480k
[    0.182558] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    0.182967] Freeing unused kernel image (rodata/data gap) memory: 1648K
[    0.205800] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.205803] Run /init as init process
[    0.205804]   with arguments:
[    0.205804]     /init
[    0.205804]   with environment:
[    0.205805]     HOME=/
[    0.205805]     TERM=linux
[    0.220007] scsi 0:0:0:0: Direct-Access     Msft     Virtual Disk     1.0  PQ: 0 ANSI: 5
[    0.220351] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    0.221036] sd 0:0:0:0: [sda] 536870912 512-byte logical blocks: (275 GB/256 GiB)
[    0.221038] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    0.221129] sd 0:0:0:0: [sda] Write Protect is off
[    0.221131] sd 0:0:0:0: [sda] Mode Sense: 0f 00 00 00
[    0.221336] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.511918] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.514767] EXT4-fs (sda): mounted filesystem with ordered data mode. Opts: discard,errors=remount-ro,data=ordered
[    1.151704] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6d8cc2767c9, max_idle_ns: 881590832756 ns
[    1.151710] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    1.152495] clocksource: Switched to clocksource tsc
[    2.415695] FS-Cache: Duplicate cookie detected
[    2.415698] FS-Cache: O-cookie c=00000000c02fe849 [p=000000000adfc1b6 fl=222 nc=0 na=1]
[    2.415698] FS-Cache: O-cookie d=00000000f83f6a98 n=000000009337a48d
[    2.415699] FS-Cache: O-key=[10] '34323934393337353334'
[    2.415702] FS-Cache: N-cookie c=00000000180bc5ec [p=000000000adfc1b6 fl=2 nc=0 na=1]
[    2.415702] FS-Cache: N-cookie d=00000000f83f6a98 n=00000000a8258158
[    2.415702] FS-Cache: N-key=[10] '34323934393337353334'
[    2.425813] ------------[ cut here ]------------
[    2.425817] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425819] CPU: 14 PID: 260 Comm: init Not tainted 5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.425820] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425821] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.425822] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.425823] RAX: 0000000000000000 RBX: ffffa2da072dd800 RCX: ffffb41300653e50
[    2.425823] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd800
[    2.425824] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3d17
[    2.425824] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.425825] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.425827] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.425828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.425828] CR2: 0000000001a95ff0 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.425829] Call Trace:
[    2.425831]  do_iter_read+0xf2/0x160
[    2.425832]  vfs_readv+0x69/0xb0
[    2.425833]  do_readv+0x66/0x110
[    2.425835]  do_syscall_64+0x33/0x80
[    2.425836]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.425837] RIP: 0033:0x22c483
[    2.425837] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.425838] RSP: 002b:00007fffa68e3cd0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.425839] RAX: ffffffffffffffda RBX: 0000000001a949a0 RCX: 000000000022c483
[    2.425839] RDX: 0000000000000002 RSI: 00007fffa68e3cd0 RDI: 0000000000000010
[    2.425840] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.425840] R10: 0000000000000008 R11: 0000000000000257 R12: 0000000001a949a0
[    2.425840] R13: 00007fffa68e3e18 R14: 0000000000000001 R15: 00007fffa68e3d17
[    2.425841] CPU: 14 PID: 260 Comm: init Not tainted 5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.425842] Call Trace:
[    2.425843]  dump_stack+0x57/0x6a
[    2.425845]  __warn.cold+0x24/0x39
[    2.425846]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425847]  report_bug+0xd3/0xf0
[    2.425848]  handle_bug+0x3c/0x60
[    2.425849]  exc_invalid_op+0x14/0x60
[    2.425850]  asm_exc_invalid_op+0x12/0x20
[    2.425851] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425852] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.425852] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.425853] RAX: 0000000000000000 RBX: ffffa2da072dd800 RCX: ffffb41300653e50
[    2.425853] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd800
[    2.425853] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3d17
[    2.425854] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.425854] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.425855]  do_iter_read+0xf2/0x160
[    2.425856]  vfs_readv+0x69/0xb0
[    2.425856]  do_readv+0x66/0x110
[    2.425857]  do_syscall_64+0x33/0x80
[    2.425858]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.425859] RIP: 0033:0x22c483
[    2.425859] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.425860] RSP: 002b:00007fffa68e3cd0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.425860] RAX: ffffffffffffffda RBX: 0000000001a949a0 RCX: 000000000022c483
[    2.425861] RDX: 0000000000000002 RSI: 00007fffa68e3cd0 RDI: 0000000000000010
[    2.425861] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.425861] R10: 0000000000000008 R11: 0000000000000257 R12: 0000000001a949a0
[    2.425862] R13: 00007fffa68e3e18 R14: 0000000000000001 R15: 00007fffa68e3d17
[    2.425862] ---[ end trace b52c3dd5183e4b0e ]---
[    2.425863] odd readv on /9/mountinfo/
[    2.425892] ------------[ cut here ]------------
[    2.425894] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425894] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.425895] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425896] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.425896] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.425897] RAX: 0000000000000000 RBX: ffffa2da072dd800 RCX: ffffb41300653e50
[    2.425897] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd800
[    2.425898] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3d17
[    2.425898] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.425898] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.425900] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.425900] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.425901] CR2: 0000000001a95ff0 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.425901] Call Trace:
[    2.425902]  do_iter_read+0xf2/0x160
[    2.425902]  vfs_readv+0x69/0xb0
[    2.425903]  do_readv+0x66/0x110
[    2.425904]  do_syscall_64+0x33/0x80
[    2.425905]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.425905] RIP: 0033:0x22c483
[    2.425906] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.425906] RSP: 002b:00007fffa68e3cd0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.425907] RAX: ffffffffffffffda RBX: 0000000001a949a0 RCX: 000000000022c483
[    2.425907] RDX: 0000000000000002 RSI: 00007fffa68e3cd0 RDI: 0000000000000010
[    2.425907] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.425908] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a949a0
[    2.425908] R13: 00007fffa68e3e18 R14: 0000000000000001 R15: 00007fffa68e3d17
[    2.425909] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.425909] Call Trace:
[    2.425910]  dump_stack+0x57/0x6a
[    2.425911]  __warn.cold+0x24/0x39
[    2.425912]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425913]  report_bug+0xd3/0xf0
[    2.425914]  handle_bug+0x3c/0x60
[    2.425915]  exc_invalid_op+0x14/0x60
[    2.425915]  asm_exc_invalid_op+0x12/0x20
[    2.425916] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425917] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.425917] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.425918] RAX: 0000000000000000 RBX: ffffa2da072dd800 RCX: ffffb41300653e50
[    2.425918] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd800
[    2.425919] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3d17
[    2.425919] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.425919] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.425920]  do_iter_read+0xf2/0x160
[    2.425921]  vfs_readv+0x69/0xb0
[    2.425921]  do_readv+0x66/0x110
[    2.425922]  do_syscall_64+0x33/0x80
[    2.425923]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.425923] RIP: 0033:0x22c483
[    2.425924] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.425924] RSP: 002b:00007fffa68e3cd0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.425925] RAX: ffffffffffffffda RBX: 0000000001a949a0 RCX: 000000000022c483
[    2.425925] RDX: 0000000000000002 RSI: 00007fffa68e3cd0 RDI: 0000000000000010
[    2.425926] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.425926] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a949a0
[    2.425927] R13: 00007fffa68e3e18 R14: 0000000000000001 R15: 00007fffa68e3d17
[    2.425927] ---[ end trace b52c3dd5183e4b0f ]---
[    2.425927] odd readv on /9/mountinfo/
[    2.425931] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.425935] init: (9) ERROR: CreateProcessParseCommon:849: Failed to translate C:\Users\natec

[    2.425947] ------------[ cut here ]------------
[    2.425948] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425949] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.425949] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425950] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.425950] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.425951] RAX: 0000000000000000 RBX: ffffa2da072dd000 RCX: ffffb41300653e50
[    2.425951] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd000
[    2.425952] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.425952] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.425952] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.425954] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.425954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.425955] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.425955] Call Trace:
[    2.425956]  do_iter_read+0xf2/0x160
[    2.425956]  vfs_readv+0x69/0xb0
[    2.425957]  ? kmem_cache_free+0x7d/0x370
[    2.425958]  ? do_sys_openat2+0x1a2/0x2d0
[    2.425959]  do_readv+0x66/0x110
[    2.425960]  do_syscall_64+0x33/0x80
[    2.425961]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.425961] RIP: 0033:0x22c483
[    2.425962] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.425962] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.425963] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.425963] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.425963] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.425964] R10: 00007fffa68e4ca0 R11: 0000000000000257 R12: 0000000001a94b00
[    2.425964] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.425965] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.425965] Call Trace:
[    2.425966]  dump_stack+0x57/0x6a
[    2.425967]  __warn.cold+0x24/0x39
[    2.425968]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425968]  report_bug+0xd3/0xf0
[    2.425969]  handle_bug+0x3c/0x60
[    2.425970]  exc_invalid_op+0x14/0x60
[    2.425971]  asm_exc_invalid_op+0x12/0x20
[    2.425972] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.425973] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.425973] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.425973] RAX: 0000000000000000 RBX: ffffa2da072dd000 RCX: ffffb41300653e50
[    2.425974] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd000
[    2.425974] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.425975] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.425975] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.425976]  do_iter_read+0xf2/0x160
[    2.425976]  vfs_readv+0x69/0xb0
[    2.425977]  ? kmem_cache_free+0x7d/0x370
[    2.425978]  ? do_sys_openat2+0x1a2/0x2d0
[    2.425978]  do_readv+0x66/0x110
[    2.425979]  do_syscall_64+0x33/0x80
[    2.425980]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.425980] RIP: 0033:0x22c483
[    2.425981] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.425981] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.425982] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.425982] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.425983] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.425983] R10: 00007fffa68e4ca0 R11: 0000000000000257 R12: 0000000001a94b00
[    2.425983] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.425984] ---[ end trace b52c3dd5183e4b10 ]---
[    2.425984] odd readv on /9/mountinfo/
[    2.426002] ------------[ cut here ]------------
[    2.426003] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426004] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426004] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426005] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426005] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426006] RAX: 0000000000000000 RBX: ffffa2da072dd000 RCX: ffffb41300653e50
[    2.426006] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd000
[    2.426007] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426007] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426007] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426009] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426020] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426021] Call Trace:
[    2.426022]  do_iter_read+0xf2/0x160
[    2.426023]  vfs_readv+0x69/0xb0
[    2.426023]  ? kmem_cache_free+0x7d/0x370
[    2.426024]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426025]  do_readv+0x66/0x110
[    2.426026]  do_syscall_64+0x33/0x80
[    2.426026]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426027] RIP: 0033:0x22c483
[    2.426028] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426028] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426029] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426029] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426030] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426030] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426031] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426032] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426032] Call Trace:
[    2.426033]  dump_stack+0x57/0x6a
[    2.426034]  __warn.cold+0x24/0x39
[    2.426035]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426036]  report_bug+0xd3/0xf0
[    2.426037]  handle_bug+0x3c/0x60
[    2.426038]  exc_invalid_op+0x14/0x60
[    2.426039]  asm_exc_invalid_op+0x12/0x20
[    2.426039] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426040] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426040] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426041] RAX: 0000000000000000 RBX: ffffa2da072dd000 RCX: ffffb41300653e50
[    2.426041] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd000
[    2.426042] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426042] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426043] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426043]  do_iter_read+0xf2/0x160
[    2.426044]  vfs_readv+0x69/0xb0
[    2.426045]  ? kmem_cache_free+0x7d/0x370
[    2.426045]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426046]  do_readv+0x66/0x110
[    2.426047]  do_syscall_64+0x33/0x80
[    2.426048]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426048] RIP: 0033:0x22c483
[    2.426049] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426049] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426049] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426050] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426050] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426051] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426051] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426052] ---[ end trace b52c3dd5183e4b11 ]---
[    2.426052] odd readv on /9/mountinfo/
[    2.426055] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.426058] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows\system32

[    2.426065] ------------[ cut here ]------------
[    2.426066] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426067] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426068] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426068] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426069] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426069] RAX: 0000000000000000 RBX: ffffa2da072ddb00 RCX: ffffb41300653e50
[    2.426069] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072ddb00
[    2.426070] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426070] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426071] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426072] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426073] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426073] Call Trace:
[    2.426074]  do_iter_read+0xf2/0x160
[    2.426074]  vfs_readv+0x69/0xb0
[    2.426075]  ? kmem_cache_free+0x7d/0x370
[    2.426076]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426076]  do_readv+0x66/0x110
[    2.426077]  do_syscall_64+0x33/0x80
[    2.426078]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426079] RIP: 0033:0x22c483
[    2.426079] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426079] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426080] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426080] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426081] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426081] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426082] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426082] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426083] Call Trace:
[    2.426083]  dump_stack+0x57/0x6a
[    2.426084]  __warn.cold+0x24/0x39
[    2.426085]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426086]  report_bug+0xd3/0xf0
[    2.426087]  handle_bug+0x3c/0x60
[    2.426088]  exc_invalid_op+0x14/0x60
[    2.426089]  asm_exc_invalid_op+0x12/0x20
[    2.426089] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426090] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426090] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426091] RAX: 0000000000000000 RBX: ffffa2da072ddb00 RCX: ffffb41300653e50
[    2.426091] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072ddb00
[    2.426092] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426092] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426092] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426093]  do_iter_read+0xf2/0x160
[    2.426094]  vfs_readv+0x69/0xb0
[    2.426094]  ? kmem_cache_free+0x7d/0x370
[    2.426095]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426096]  do_readv+0x66/0x110
[    2.426096]  do_syscall_64+0x33/0x80
[    2.426097]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426098] RIP: 0033:0x22c483
[    2.426098] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426099] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426099] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426100] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426100] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426100] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426101] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426101] ---[ end trace b52c3dd5183e4b12 ]---
[    2.426102] odd readv on /9/mountinfo/
[    2.426121] ------------[ cut here ]------------
[    2.426122] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426123] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426123] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426124] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426124] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426125] RAX: 0000000000000000 RBX: ffffa2da072ddb00 RCX: ffffb41300653e50
[    2.426125] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072ddb00
[    2.426126] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426126] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426127] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426128] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426129] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426129] Call Trace:
[    2.426130]  do_iter_read+0xf2/0x160
[    2.426130]  vfs_readv+0x69/0xb0
[    2.426131]  ? kmem_cache_free+0x7d/0x370
[    2.426132]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426132]  do_readv+0x66/0x110
[    2.426133]  do_syscall_64+0x33/0x80
[    2.426134]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426134] RIP: 0033:0x22c483
[    2.426135] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426135] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426136] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426136] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426137] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426137] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426137] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426138] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426138] Call Trace:
[    2.426139]  dump_stack+0x57/0x6a
[    2.426140]  __warn.cold+0x24/0x39
[    2.426141]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426142]  report_bug+0xd3/0xf0
[    2.426143]  handle_bug+0x3c/0x60
[    2.426144]  exc_invalid_op+0x14/0x60
[    2.426144]  asm_exc_invalid_op+0x12/0x20
[    2.426145] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426146] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426146] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426147] RAX: 0000000000000000 RBX: ffffa2da072ddb00 RCX: ffffb41300653e50
[    2.426147] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072ddb00
[    2.426147] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426148] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426148] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426149]  do_iter_read+0xf2/0x160
[    2.426150]  vfs_readv+0x69/0xb0
[    2.426150]  ? kmem_cache_free+0x7d/0x370
[    2.426151]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426151]  do_readv+0x66/0x110
[    2.426152]  do_syscall_64+0x33/0x80
[    2.426153]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426154] RIP: 0033:0x22c483
[    2.426154] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426155] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426155] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426156] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426156] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426156] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426157] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426157] ---[ end trace b52c3dd5183e4b13 ]---
[    2.426158] odd readv on /9/mountinfo/
[    2.426159] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.426161] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows
[    2.426165] ------------[ cut here ]------------
[    2.426166] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426166] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426167] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426167] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426168] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426168] RAX: 0000000000000000 RBX: ffffa2da072dc600 RCX: ffffb41300653e50
[    2.426169] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc600
[    2.426169] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426169] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426170] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426171] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426172] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426172] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426172] Call Trace:
[    2.426173]  do_iter_read+0xf2/0x160
[    2.426173]  vfs_readv+0x69/0xb0
[    2.426174]  ? kmem_cache_free+0x7d/0x370
[    2.426175]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426175]  do_readv+0x66/0x110
[    2.426176]  do_syscall_64+0x33/0x80
[    2.426177]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426177] RIP: 0033:0x22c483
[    2.426178] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426178] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426179] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426179] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426180] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426180] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426181] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426181] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426182] Call Trace:
[    2.426183]  dump_stack+0x57/0x6a
[    2.426183]  __warn.cold+0x24/0x39
[    2.426184]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426185]  report_bug+0xd3/0xf0
[    2.426186]  handle_bug+0x3c/0x60
[    2.426187]  exc_invalid_op+0x14/0x60
[    2.426188]  asm_exc_invalid_op+0x12/0x20
[    2.426188] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426189] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426189] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426190] RAX: 0000000000000000 RBX: ffffa2da072dc600 RCX: ffffb41300653e50
[    2.426190] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc600
[    2.426191] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426191] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426191] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426192]  do_iter_read+0xf2/0x160
[    2.426193]  vfs_readv+0x69/0xb0
[    2.426193]  ? kmem_cache_free+0x7d/0x370
[    2.426194]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426195]  do_readv+0x66/0x110
[    2.426195]  do_syscall_64+0x33/0x80
[    2.426196]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426197] RIP: 0033:0x22c483
[    2.426197] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426198] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426198] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426199] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426199] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426199] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426200] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426200] ---[ end trace b52c3dd5183e4b14 ]---
[    2.426201] odd readv on /9/mountinfo/
[    2.426216] ------------[ cut here ]------------
[    2.426217] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426218] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426219] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426219] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426220] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426220] RAX: 0000000000000000 RBX: ffffa2da072dc600 RCX: ffffb41300653e50
[    2.426221] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc600
[    2.426221] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426221] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426222] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426223] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426224] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426224] Call Trace:
[    2.426225]  do_iter_read+0xf2/0x160
[    2.426225]  vfs_readv+0x69/0xb0
[    2.426226]  ? kmem_cache_free+0x7d/0x370
[    2.426227]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426227]  do_readv+0x66/0x110
[    2.426228]  do_syscall_64+0x33/0x80
[    2.426229]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426229] RIP: 0033:0x22c483
[    2.426230] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426230] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426231] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426231] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426232] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426232] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426232] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426233] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426233] Call Trace:
[    2.426234]  dump_stack+0x57/0x6a
[    2.426235]  __warn.cold+0x24/0x39
[    2.426236]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426237]  report_bug+0xd3/0xf0
[    2.426238]  handle_bug+0x3c/0x60
[    2.426238]  exc_invalid_op+0x14/0x60
[    2.426239]  asm_exc_invalid_op+0x12/0x20
[    2.426240] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426241] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426241] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426242] RAX: 0000000000000000 RBX: ffffa2da072dc600 RCX: ffffb41300653e50
[    2.426242] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc600
[    2.426242] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426243] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426243] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426244]  do_iter_read+0xf2/0x160
[    2.426244]  vfs_readv+0x69/0xb0
[    2.426245]  ? kmem_cache_free+0x7d/0x370
[    2.426246]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426246]  do_readv+0x66/0x110
[    2.426247]  do_syscall_64+0x33/0x80
[    2.426248]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426248] RIP: 0033:0x22c483
[    2.426249] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426249] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426250] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426250] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426251] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426251] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426252] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426252] ---[ end trace b52c3dd5183e4b15 ]---
[    2.426252] odd readv on /9/mountinfo/
[    2.426254] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.426255] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows\System32\Wbem
[    2.426259] ------------[ cut here ]------------
[    2.426260] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426261] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426261] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426262] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426262] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426263] RAX: 0000000000000000 RBX: ffffa2da072dd600 RCX: ffffb41300653e50
[    2.426263] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd600
[    2.426264] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426264] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426264] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426266] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426266] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426266] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426267] Call Trace:
[    2.426267]  do_iter_read+0xf2/0x160
[    2.426268]  vfs_readv+0x69/0xb0
[    2.426268]  ? kmem_cache_free+0x7d/0x370
[    2.426269]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426270]  do_readv+0x66/0x110
[    2.426271]  do_syscall_64+0x33/0x80
[    2.426271]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426272] RIP: 0033:0x22c483
[    2.426272] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426273] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426273] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426274] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426274] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426275] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426275] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426276] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426276] Call Trace:
[    2.426277]  dump_stack+0x57/0x6a
[    2.426278]  __warn.cold+0x24/0x39
[    2.426278]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426279]  report_bug+0xd3/0xf0
[    2.426280]  handle_bug+0x3c/0x60
[    2.426281]  exc_invalid_op+0x14/0x60
[    2.426282]  asm_exc_invalid_op+0x12/0x20
[    2.426283] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426283] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426283] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426284] RAX: 0000000000000000 RBX: ffffa2da072dd600 RCX: ffffb41300653e50
[    2.426284] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd600
[    2.426285] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426285] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426286] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426286]  do_iter_read+0xf2/0x160
[    2.426287]  vfs_readv+0x69/0xb0
[    2.426287]  ? kmem_cache_free+0x7d/0x370
[    2.426288]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426289]  do_readv+0x66/0x110
[    2.426290]  do_syscall_64+0x33/0x80
[    2.426290]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426291] RIP: 0033:0x22c483
[    2.426291] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426292] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426292] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426293] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426293] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426294] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426294] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426294] ---[ end trace b52c3dd5183e4b16 ]---
[    2.426295] odd readv on /9/mountinfo/
[    2.426310] ------------[ cut here ]------------
[    2.426311] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426311] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426312] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426313] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426313] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426314] RAX: 0000000000000000 RBX: ffffa2da072dd600 RCX: ffffb41300653e50
[    2.426314] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd600
[    2.426314] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426315] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426315] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426316] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426317] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426317] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426317] Call Trace:
[    2.426318]  do_iter_read+0xf2/0x160
[    2.426319]  vfs_readv+0x69/0xb0
[    2.426319]  ? kmem_cache_free+0x7d/0x370
[    2.426320]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426321]  do_readv+0x66/0x110
[    2.426321]  do_syscall_64+0x33/0x80
[    2.426322]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426323] RIP: 0033:0x22c483
[    2.426323] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426324] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426324] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426325] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426325] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426325] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426326] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426326] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426327] Call Trace:
[    2.426328]  dump_stack+0x57/0x6a
[    2.426328]  __warn.cold+0x24/0x39
[    2.426329]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426330]  report_bug+0xd3/0xf0
[    2.426331]  handle_bug+0x3c/0x60
[    2.426332]  exc_invalid_op+0x14/0x60
[    2.426333]  asm_exc_invalid_op+0x12/0x20
[    2.426333] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426334] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426334] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426335] RAX: 0000000000000000 RBX: ffffa2da072dd600 RCX: ffffb41300653e50
[    2.426335] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd600
[    2.426336] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426336] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426336] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426337]  do_iter_read+0xf2/0x160
[    2.426338]  vfs_readv+0x69/0xb0
[    2.426338]  ? kmem_cache_free+0x7d/0x370
[    2.426339]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426340]  do_readv+0x66/0x110
[    2.426340]  do_syscall_64+0x33/0x80
[    2.426341]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426342] RIP: 0033:0x22c483
[    2.426342] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426343] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426343] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426344] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426344] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426344] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426345] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426345] ---[ end trace b52c3dd5183e4b17 ]---
[    2.426346] odd readv on /9/mountinfo/
[    2.426351] ------------[ cut here ]------------
[    2.426352] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426353] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426353] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426354] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426354] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426355] RAX: 0000000000000000 RBX: ffffa2da072dc700 RCX: ffffb41300653e50
[    2.426355] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc700
[    2.426355] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426356] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426356] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426358] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426358] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426358] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426359] Call Trace:
[    2.426359]  do_iter_read+0xf2/0x160
[    2.426360]  vfs_readv+0x69/0xb0
[    2.426360]  ? kmem_cache_free+0x7d/0x370
[    2.426361]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426362]  do_readv+0x66/0x110
[    2.426363]  do_syscall_64+0x33/0x80
[    2.426363]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426364] RIP: 0033:0x22c483
[    2.426364] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426365] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426365] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426366] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426366] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426366] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426367] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426368] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426368] Call Trace:
[    2.426369]  dump_stack+0x57/0x6a
[    2.426369]  __warn.cold+0x24/0x39
[    2.426370]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426371]  report_bug+0xd3/0xf0
[    2.426372]  handle_bug+0x3c/0x60
[    2.426373]  exc_invalid_op+0x14/0x60
[    2.426374]  asm_exc_invalid_op+0x12/0x20
[    2.426375] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426375] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426375] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426376] RAX: 0000000000000000 RBX: ffffa2da072dc700 RCX: ffffb41300653e50
[    2.426376] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc700
[    2.426377] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426377] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426378] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426378]  do_iter_read+0xf2/0x160
[    2.426379]  vfs_readv+0x69/0xb0
[    2.426379]  ? kmem_cache_free+0x7d/0x370
[    2.426380]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426381]  do_readv+0x66/0x110
[    2.426382]  do_syscall_64+0x33/0x80
[    2.426382]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426383] RIP: 0033:0x22c483
[    2.426383] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426384] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426384] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426385] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426385] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426385] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426386] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426386] ---[ end trace b52c3dd5183e4b18 ]---
[    2.426387] odd readv on /9/mountinfo/
[    2.426402] ------------[ cut here ]------------
[    2.426402] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426403] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426404] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426404] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426405] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426405] RAX: 0000000000000000 RBX: ffffa2da072dc700 RCX: ffffb41300653e50
[    2.426406] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc700
[    2.426406] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426406] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426407] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426408] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426408] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426409] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426409] Call Trace:
[    2.426410]  do_iter_read+0xf2/0x160
[    2.426410]  vfs_readv+0x69/0xb0
[    2.426411]  ? kmem_cache_free+0x7d/0x370
[    2.426412]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426412]  do_readv+0x66/0x110
[    2.426413]  do_syscall_64+0x33/0x80
[    2.426414]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426414] RIP: 0033:0x22c483
[    2.426415] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426415] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426416] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426416] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426417] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426417] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426417] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426418] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426418] Call Trace:
[    2.426419]  dump_stack+0x57/0x6a
[    2.426420]  __warn.cold+0x24/0x39
[    2.426421]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426422]  report_bug+0xd3/0xf0
[    2.426422]  handle_bug+0x3c/0x60
[    2.426423]  exc_invalid_op+0x14/0x60
[    2.426424]  asm_exc_invalid_op+0x12/0x20
[    2.426425] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426426] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426426] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426426] RAX: 0000000000000000 RBX: ffffa2da072dc700 RCX: ffffb41300653e50
[    2.426427] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc700
[    2.426427] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426428] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426428] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426429]  do_iter_read+0xf2/0x160
[    2.426429]  vfs_readv+0x69/0xb0
[    2.426430]  ? kmem_cache_free+0x7d/0x370
[    2.426431]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426431]  do_readv+0x66/0x110
[    2.426432]  do_syscall_64+0x33/0x80
[    2.426433]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426433] RIP: 0033:0x22c483
[    2.426434] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426434] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426435] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426435] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426436] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426436] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426436] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426437] ---[ end trace b52c3dd5183e4b19 ]---
[    2.426437] odd readv on /9/mountinfo/
[    2.426443] ------------[ cut here ]------------
[    2.426443] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426444] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426445] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426445] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426446] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426446] RAX: 0000000000000000 RBX: ffffa2da072dc000 RCX: ffffb41300653e50
[    2.426447] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc000
[    2.426447] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426447] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426448] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426449] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426449] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426450] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426450] Call Trace:
[    2.426451]  do_iter_read+0xf2/0x160
[    2.426451]  vfs_readv+0x69/0xb0
[    2.426452]  ? kmem_cache_free+0x7d/0x370
[    2.426453]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426453]  do_readv+0x66/0x110
[    2.426454]  do_syscall_64+0x33/0x80
[    2.426455]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426455] RIP: 0033:0x22c483
[    2.426456] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426456] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426457] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426457] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426458] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426458] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426458] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426459] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426459] Call Trace:
[    2.426460]  dump_stack+0x57/0x6a
[    2.426461]  __warn.cold+0x24/0x39
[    2.426462]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426463]  report_bug+0xd3/0xf0
[    2.426463]  handle_bug+0x3c/0x60
[    2.426464]  exc_invalid_op+0x14/0x60
[    2.426465]  asm_exc_invalid_op+0x12/0x20
[    2.426466] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426467] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426467] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426467] RAX: 0000000000000000 RBX: ffffa2da072dc000 RCX: ffffb41300653e50
[    2.426468] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc000
[    2.426468] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426469] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426469] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426470]  do_iter_read+0xf2/0x160
[    2.426470]  vfs_readv+0x69/0xb0
[    2.426471]  ? kmem_cache_free+0x7d/0x370
[    2.426472]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426472]  do_readv+0x66/0x110
[    2.426473]  do_syscall_64+0x33/0x80
[    2.426474]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426474] RIP: 0033:0x22c483
[    2.426475] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426475] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426476] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426476] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426477] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426477] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426477] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426478] ---[ end trace b52c3dd5183e4b1a ]---
[    2.426478] odd readv on /9/mountinfo/
[    2.426493] ------------[ cut here ]------------
[    2.426494] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426494] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426495] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426496] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426496] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426497] RAX: 0000000000000000 RBX: ffffa2da072dc000 RCX: ffffb41300653e50
[    2.426497] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc000
[    2.426497] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426498] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426498] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426499] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426500] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426500] Call Trace:
[    2.426501]  do_iter_read+0xf2/0x160
[    2.426502]  vfs_readv+0x69/0xb0
[    2.426502]  ? kmem_cache_free+0x7d/0x370
[    2.426503]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426503]  do_readv+0x66/0x110
[    2.426504]  do_syscall_64+0x33/0x80
[    2.426505]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426506] RIP: 0033:0x22c483
[    2.426506] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426507] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426507] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426507] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426508] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426508] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426509] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426509] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426510] Call Trace:
[    2.426510]  dump_stack+0x57/0x6a
[    2.426511]  __warn.cold+0x24/0x39
[    2.426512]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426513]  report_bug+0xd3/0xf0
[    2.426514]  handle_bug+0x3c/0x60
[    2.426515]  exc_invalid_op+0x14/0x60
[    2.426516]  asm_exc_invalid_op+0x12/0x20
[    2.426516] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426517] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426517] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426518] RAX: 0000000000000000 RBX: ffffa2da072dc000 RCX: ffffb41300653e50
[    2.426518] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dc000
[    2.426518] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426519] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426519] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426520]  do_iter_read+0xf2/0x160
[    2.426521]  vfs_readv+0x69/0xb0
[    2.426521]  ? kmem_cache_free+0x7d/0x370
[    2.426522]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426522]  do_readv+0x66/0x110
[    2.426523]  do_syscall_64+0x33/0x80
[    2.426524]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426525] RIP: 0033:0x22c483
[    2.426525] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426525] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426526] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426526] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426527] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426527] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426528] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426528] ---[ end trace b52c3dd5183e4b1b ]---
[    2.426528] odd readv on /9/mountinfo/
[    2.426534] ------------[ cut here ]------------
[    2.426535] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426535] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426536] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426537] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426537] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426538] RAX: 0000000000000000 RBX: ffffa2da072dca00 RCX: ffffb41300653e50
[    2.426538] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dca00
[    2.426538] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426539] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426539] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426540] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426541] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426541] Call Trace:
[    2.426542]  do_iter_read+0xf2/0x160
[    2.426543]  vfs_readv+0x69/0xb0
[    2.426543]  ? kmem_cache_free+0x7d/0x370
[    2.426544]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426544]  do_readv+0x66/0x110
[    2.426545]  do_syscall_64+0x33/0x80
[    2.426546]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426547] RIP: 0033:0x22c483
[    2.426547] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426547] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426548] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426548] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426549] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426549] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426550] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426550] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426551] Call Trace:
[    2.426552]  dump_stack+0x57/0x6a
[    2.426552]  __warn.cold+0x24/0x39
[    2.426553]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426554]  report_bug+0xd3/0xf0
[    2.426555]  handle_bug+0x3c/0x60
[    2.426556]  exc_invalid_op+0x14/0x60
[    2.426557]  asm_exc_invalid_op+0x12/0x20
[    2.426557] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426558] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426558] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426559] RAX: 0000000000000000 RBX: ffffa2da072dca00 RCX: ffffb41300653e50
[    2.426559] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dca00
[    2.426560] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426560] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426560] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426561]  do_iter_read+0xf2/0x160
[    2.426562]  vfs_readv+0x69/0xb0
[    2.426562]  ? kmem_cache_free+0x7d/0x370
[    2.426563]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426563]  do_readv+0x66/0x110
[    2.426564]  do_syscall_64+0x33/0x80
[    2.426565]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426566] RIP: 0033:0x22c483
[    2.426566] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426567] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426567] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426567] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426568] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426568] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426569] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426569] ---[ end trace b52c3dd5183e4b1c ]---
[    2.426569] odd readv on /9/mountinfo/
[    2.426584] ------------[ cut here ]------------
[    2.426585] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426586] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426586] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426587] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426587] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426588] RAX: 0000000000000000 RBX: ffffa2da072dca00 RCX: ffffb41300653e50
[    2.426588] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dca00
[    2.426589] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426589] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426589] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426591] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426591] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426592] Call Trace:
[    2.426592]  do_iter_read+0xf2/0x160
[    2.426593]  vfs_readv+0x69/0xb0
[    2.426594]  ? kmem_cache_free+0x7d/0x370
[    2.426594]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426595]  do_readv+0x66/0x110
[    2.426596]  do_syscall_64+0x33/0x80
[    2.426596]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426597] RIP: 0033:0x22c483
[    2.426597] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426598] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426598] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426599] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426599] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426600] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426600] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426601] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426601] Call Trace:
[    2.426602]  dump_stack+0x57/0x6a
[    2.426603]  __warn.cold+0x24/0x39
[    2.426603]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426604]  report_bug+0xd3/0xf0
[    2.426605]  handle_bug+0x3c/0x60
[    2.426606]  exc_invalid_op+0x14/0x60
[    2.426607]  asm_exc_invalid_op+0x12/0x20
[    2.426608] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426608] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426608] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426609] RAX: 0000000000000000 RBX: ffffa2da072dca00 RCX: ffffb41300653e50
[    2.426609] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dca00
[    2.426610] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426610] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426611] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426611]  do_iter_read+0xf2/0x160
[    2.426612]  vfs_readv+0x69/0xb0
[    2.426612]  ? kmem_cache_free+0x7d/0x370
[    2.426613]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426614]  do_readv+0x66/0x110
[    2.426615]  do_syscall_64+0x33/0x80
[    2.426615]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426616] RIP: 0033:0x22c483
[    2.426616] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426617] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426617] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426618] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426618] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426619] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426619] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426619] ---[ end trace b52c3dd5183e4b1d ]---
[    2.426620] odd readv on /9/mountinfo/
[    2.426625] ------------[ cut here ]------------
[    2.426626] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426627] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426627] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426628] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426628] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426629] RAX: 0000000000000000 RBX: ffffa2da072dce00 RCX: ffffb41300653e50
[    2.426629] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dce00
[    2.426630] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426630] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426630] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426631] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426632] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426633] Call Trace:
[    2.426633]  do_iter_read+0xf2/0x160
[    2.426634]  vfs_readv+0x69/0xb0
[    2.426634]  ? kmem_cache_free+0x7d/0x370
[    2.426635]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426636]  do_readv+0x66/0x110
[    2.426636]  do_syscall_64+0x33/0x80
[    2.426637]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426638] RIP: 0033:0x22c483
[    2.426638] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426639] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426639] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426640] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426640] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426640] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426641] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426642] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426642] Call Trace:
[    2.426643]  dump_stack+0x57/0x6a
[    2.426643]  __warn.cold+0x24/0x39
[    2.426644]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426645]  report_bug+0xd3/0xf0
[    2.426646]  handle_bug+0x3c/0x60
[    2.426647]  exc_invalid_op+0x14/0x60
[    2.426648]  asm_exc_invalid_op+0x12/0x20
[    2.426648] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426649] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426649] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426650] RAX: 0000000000000000 RBX: ffffa2da072dce00 RCX: ffffb41300653e50
[    2.426650] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dce00
[    2.426651] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426651] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426651] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426652]  do_iter_read+0xf2/0x160
[    2.426653]  vfs_readv+0x69/0xb0
[    2.426653]  ? kmem_cache_free+0x7d/0x370
[    2.426654]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426655]  do_readv+0x66/0x110
[    2.426655]  do_syscall_64+0x33/0x80
[    2.426656]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426657] RIP: 0033:0x22c483
[    2.426657] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426658] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426658] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426659] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426659] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426659] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426660] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426660] ---[ end trace b52c3dd5183e4b1e ]---
[    2.426661] odd readv on /9/mountinfo/
[    2.426675] ------------[ cut here ]------------
[    2.426676] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426677] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426677] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426678] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426678] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426679] RAX: 0000000000000000 RBX: ffffa2da072dce00 RCX: ffffb41300653e50
[    2.426679] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dce00
[    2.426680] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426680] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426680] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426682] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426682] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426682] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426683] Call Trace:
[    2.426683]  do_iter_read+0xf2/0x160
[    2.426684]  vfs_readv+0x69/0xb0
[    2.426685]  ? kmem_cache_free+0x7d/0x370
[    2.426685]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426686]  do_readv+0x66/0x110
[    2.426687]  do_syscall_64+0x33/0x80
[    2.426687]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426688] RIP: 0033:0x22c483
[    2.426688] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426689] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426689] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426690] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426690] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426691] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426691] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426692] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426692] Call Trace:
[    2.426693]  dump_stack+0x57/0x6a
[    2.426694]  __warn.cold+0x24/0x39
[    2.426694]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426695]  report_bug+0xd3/0xf0
[    2.426696]  handle_bug+0x3c/0x60
[    2.426697]  exc_invalid_op+0x14/0x60
[    2.426698]  asm_exc_invalid_op+0x12/0x20
[    2.426699] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426699] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426699] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426700] RAX: 0000000000000000 RBX: ffffa2da072dce00 RCX: ffffb41300653e50
[    2.426700] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dce00
[    2.426701] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426701] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426702] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426702]  do_iter_read+0xf2/0x160
[    2.426703]  vfs_readv+0x69/0xb0
[    2.426703]  ? kmem_cache_free+0x7d/0x370
[    2.426704]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426705]  do_readv+0x66/0x110
[    2.426706]  do_syscall_64+0x33/0x80
[    2.426706]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426707] RIP: 0033:0x22c483
[    2.426707] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426708] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426708] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426709] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426709] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426709] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426710] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426710] ---[ end trace b52c3dd5183e4b1f ]---
[    2.426711] odd readv on /9/mountinfo/
[    2.426716] ------------[ cut here ]------------
[    2.426717] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426718] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426718] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426719] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426719] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426720] RAX: 0000000000000000 RBX: ffffa2da072dd900 RCX: ffffb41300653e50
[    2.426720] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd900
[    2.426721] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426721] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426721] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426723] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426723] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426723] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426724] Call Trace:
[    2.426724]  do_iter_read+0xf2/0x160
[    2.426725]  vfs_readv+0x69/0xb0
[    2.426725]  ? kmem_cache_free+0x7d/0x370
[    2.426726]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426727]  do_readv+0x66/0x110
[    2.426728]  do_syscall_64+0x33/0x80
[    2.426728]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426729] RIP: 0033:0x22c483
[    2.426729] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426730] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426730] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426731] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426731] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426731] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426732] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426733] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426733] Call Trace:
[    2.426734]  dump_stack+0x57/0x6a
[    2.426734]  __warn.cold+0x24/0x39
[    2.426735]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426736]  report_bug+0xd3/0xf0
[    2.426737]  handle_bug+0x3c/0x60
[    2.426738]  exc_invalid_op+0x14/0x60
[    2.426739]  asm_exc_invalid_op+0x12/0x20
[    2.426740] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426740] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426740] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426741] RAX: 0000000000000000 RBX: ffffa2da072dd900 RCX: ffffb41300653e50
[    2.426741] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd900
[    2.426742] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426742] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426742] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426743]  do_iter_read+0xf2/0x160
[    2.426744]  vfs_readv+0x69/0xb0
[    2.426744]  ? kmem_cache_free+0x7d/0x370
[    2.426745]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426746]  do_readv+0x66/0x110
[    2.426747]  do_syscall_64+0x33/0x80
[    2.426747]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426748] RIP: 0033:0x22c483
[    2.426748] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426749] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426749] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426750] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426750] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426750] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426751] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426751] ---[ end trace b52c3dd5183e4b20 ]---
[    2.426752] odd readv on /9/mountinfo/
[    2.426766] ------------[ cut here ]------------
[    2.426767] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426768] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426769] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426769] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426769] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426770] RAX: 0000000000000000 RBX: ffffa2da072dd900 RCX: ffffb41300653e50
[    2.426770] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd900
[    2.426771] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426771] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426772] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426773] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426774] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426774] Call Trace:
[    2.426774]  do_iter_read+0xf2/0x160
[    2.426775]  vfs_readv+0x69/0xb0
[    2.426776]  ? kmem_cache_free+0x7d/0x370
[    2.426776]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426777]  do_readv+0x66/0x110
[    2.426778]  do_syscall_64+0x33/0x80
[    2.426779]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426779] RIP: 0033:0x22c483
[    2.426780] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426780] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426780] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426781] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426781] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426782] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426782] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426783] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426783] Call Trace:
[    2.426784]  dump_stack+0x57/0x6a
[    2.426785]  __warn.cold+0x24/0x39
[    2.426785]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426786]  report_bug+0xd3/0xf0
[    2.426787]  handle_bug+0x3c/0x60
[    2.426788]  exc_invalid_op+0x14/0x60
[    2.426789]  asm_exc_invalid_op+0x12/0x20
[    2.426790] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426790] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426791] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426791] RAX: 0000000000000000 RBX: ffffa2da072dd900 RCX: ffffb41300653e50
[    2.426792] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd900
[    2.426792] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426792] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426793] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426793]  do_iter_read+0xf2/0x160
[    2.426794]  vfs_readv+0x69/0xb0
[    2.426795]  ? kmem_cache_free+0x7d/0x370
[    2.426795]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426796]  do_readv+0x66/0x110
[    2.426797]  do_syscall_64+0x33/0x80
[    2.426798]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426798] RIP: 0033:0x22c483
[    2.426799] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426799] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426799] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426800] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426800] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426801] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426801] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426802] ---[ end trace b52c3dd5183e4b21 ]---
[    2.426802] odd readv on /9/mountinfo/
[    2.426807] ------------[ cut here ]------------
[    2.426808] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426809] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426809] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426810] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426810] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426811] RAX: 0000000000000000 RBX: ffffa2da072dd300 RCX: ffffb41300653e50
[    2.426811] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd300
[    2.426812] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426812] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426812] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426814] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426814] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426814] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426815] Call Trace:
[    2.426815]  do_iter_read+0xf2/0x160
[    2.426816]  vfs_readv+0x69/0xb0
[    2.426817]  ? kmem_cache_free+0x7d/0x370
[    2.426817]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426818]  do_readv+0x66/0x110
[    2.426819]  do_syscall_64+0x33/0x80
[    2.426820]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426820] RIP: 0033:0x22c483
[    2.426820] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426821] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426821] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426822] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426822] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426823] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426823] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426824] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426824] Call Trace:
[    2.426825]  dump_stack+0x57/0x6a
[    2.426826]  __warn.cold+0x24/0x39
[    2.426826]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426827]  report_bug+0xd3/0xf0
[    2.426828]  handle_bug+0x3c/0x60
[    2.426829]  exc_invalid_op+0x14/0x60
[    2.426830]  asm_exc_invalid_op+0x12/0x20
[    2.426831] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426831] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426831] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426832] RAX: 0000000000000000 RBX: ffffa2da072dd300 RCX: ffffb41300653e50
[    2.426832] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd300
[    2.426833] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426833] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426834] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426834]  do_iter_read+0xf2/0x160
[    2.426835]  vfs_readv+0x69/0xb0
[    2.426835]  ? kmem_cache_free+0x7d/0x370
[    2.426836]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426837]  do_readv+0x66/0x110
[    2.426838]  do_syscall_64+0x33/0x80
[    2.426838]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426839] RIP: 0033:0x22c483
[    2.426839] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426840] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426840] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426841] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426841] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426842] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426842] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426842] ---[ end trace b52c3dd5183e4b22 ]---
[    2.426843] odd readv on /9/mountinfo/
[    2.426857] ------------[ cut here ]------------
[    2.426858] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426859] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426860] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426860] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426860] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426861] RAX: 0000000000000000 RBX: ffffa2da072dd300 RCX: ffffb41300653e50
[    2.426861] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd300
[    2.426862] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426862] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426863] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426864] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426865] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426865] Call Trace:
[    2.426866]  do_iter_read+0xf2/0x160
[    2.426866]  vfs_readv+0x69/0xb0
[    2.426867]  ? kmem_cache_free+0x7d/0x370
[    2.426867]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426868]  do_readv+0x66/0x110
[    2.426869]  do_syscall_64+0x33/0x80
[    2.426870]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426870] RIP: 0033:0x22c483
[    2.426871] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426871] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426872] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426872] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426872] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426873] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426873] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426874] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426874] Call Trace:
[    2.426875]  dump_stack+0x57/0x6a
[    2.426876]  __warn.cold+0x24/0x39
[    2.426877]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426877]  report_bug+0xd3/0xf0
[    2.426878]  handle_bug+0x3c/0x60
[    2.426879]  exc_invalid_op+0x14/0x60
[    2.426880]  asm_exc_invalid_op+0x12/0x20
[    2.426881] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426881] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426882] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426882] RAX: 0000000000000000 RBX: ffffa2da072dd300 RCX: ffffb41300653e50
[    2.426883] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd300
[    2.426883] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426883] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426884] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426884]  do_iter_read+0xf2/0x160
[    2.426885]  vfs_readv+0x69/0xb0
[    2.426886]  ? kmem_cache_free+0x7d/0x370
[    2.426886]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426887]  do_readv+0x66/0x110
[    2.426888]  do_syscall_64+0x33/0x80
[    2.426889]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426889] RIP: 0033:0x22c483
[    2.426890] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426890] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426891] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426891] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426891] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426892] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426892] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426893] ---[ end trace b52c3dd5183e4b23 ]---
[    2.426893] odd readv on /9/mountinfo/
[    2.426898] ------------[ cut here ]------------
[    2.426899] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426900] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426901] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426901] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426901] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426902] RAX: 0000000000000000 RBX: ffffa2da072dd700 RCX: ffffb41300653e50
[    2.426902] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd700
[    2.426903] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426903] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426904] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426905] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426905] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426906] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426906] Call Trace:
[    2.426906]  do_iter_read+0xf2/0x160
[    2.426907]  vfs_readv+0x69/0xb0
[    2.426908]  ? kmem_cache_free+0x7d/0x370
[    2.426908]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426909]  do_readv+0x66/0x110
[    2.426910]  do_syscall_64+0x33/0x80
[    2.426911]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426911] RIP: 0033:0x22c483
[    2.426912] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426912] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426913] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426913] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426913] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426914] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426914] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426915] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426915] Call Trace:
[    2.426916]  dump_stack+0x57/0x6a
[    2.426917]  __warn.cold+0x24/0x39
[    2.426918]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426918]  report_bug+0xd3/0xf0
[    2.426919]  handle_bug+0x3c/0x60
[    2.426920]  exc_invalid_op+0x14/0x60
[    2.426921]  asm_exc_invalid_op+0x12/0x20
[    2.426922] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426922] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426923] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426923] RAX: 0000000000000000 RBX: ffffa2da072dd700 RCX: ffffb41300653e50
[    2.426924] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd700
[    2.426924] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426924] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426925] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426925]  do_iter_read+0xf2/0x160
[    2.426926]  vfs_readv+0x69/0xb0
[    2.426927]  ? kmem_cache_free+0x7d/0x370
[    2.426927]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426928]  do_readv+0x66/0x110
[    2.426929]  do_syscall_64+0x33/0x80
[    2.426930]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426930] RIP: 0033:0x22c483
[    2.426931] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426931] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426931] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426932] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426932] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    2.426933] R10: 00007fffa68e4c60 R11: 0000000000000257 R12: 0000000001a94b00
[    2.426933] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426933] ---[ end trace b52c3dd5183e4b24 ]---
[    2.426934] odd readv on /9/mountinfo/
[    2.426948] ------------[ cut here ]------------
[    2.426949] WARNING: CPU: 14 PID: 260 at fs/read_write.c:761 do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426950] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426951] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426951] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426952] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426952] RAX: 0000000000000000 RBX: ffffa2da072dd700 RCX: ffffb41300653e50
[    2.426953] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd700
[    2.426953] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426953] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426954] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426955] FS:  000000000029c800(0000) GS:ffffa2dcf7b80000(0000) knlGS:0000000000000000
[    2.426955] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.426956] CR2: 00007fffa68e1c90 CR3: 0000000109096000 CR4: 0000000000350ea0
[    2.426956] Call Trace:
[    2.426957]  do_iter_read+0xf2/0x160
[    2.426957]  vfs_readv+0x69/0xb0
[    2.426958]  ? kmem_cache_free+0x7d/0x370
[    2.426959]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426959]  do_readv+0x66/0x110
[    2.426960]  do_syscall_64+0x33/0x80
[    2.426961]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426961] RIP: 0033:0x22c483
[    2.426962] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426962] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426963] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426963] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426963] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426964] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426964] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426965] CPU: 14 PID: 260 Comm: init Tainted: G        W         5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty #10
[    2.426965] Call Trace:
[    2.426966]  dump_stack+0x57/0x6a
[    2.426967]  __warn.cold+0x24/0x39
[    2.426968]  ? do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426968]  report_bug+0xd3/0xf0
[    2.426969]  handle_bug+0x3c/0x60
[    2.426970]  exc_invalid_op+0x14/0x60
[    2.426971]  asm_exc_invalid_op+0x12/0x20
[    2.426972] RIP: 0010:do_loop_readv_writev.part.0.cold+0x5/0x20
[    2.426972] Code: 44 89 ea 31 f6 48 c7 c7 08 96 1c 98 e8 11 ff ff ff 48 c7 c7 30 97 1c 98 45 31 ed e8 6b ae ff ff e9 27 32 72 ff 4c 89 4c 24 08 <0f> 0b 48 c7 c7 69 97 1c 98 48 89 de e8 50 ae ff ff 4c 8b 4c 24 08
[    2.426973] RSP: 0018:ffffb41300653d90 EFLAGS: 00010246
[    2.426973] RAX: 0000000000000000 RBX: ffffa2da072dd700 RCX: ffffb41300653e50
[    2.426974] RDX: 0000000000000000 RSI: ffffb41300653e28 RDI: ffffa2da072dd700
[    2.426974] RBP: 0000000000000000 R08: ffffb41300653e70 R09: 00007fffa68e3be7
[    2.426974] R10: ffffb41300653dd8 R11: 0000000000000000 R12: 0000000000000000
[    2.426975] R13: ffffb41300653e28 R14: ffffb41300653f08 R15: 666e69746e756f6d
[    2.426976]  do_iter_read+0xf2/0x160
[    2.426976]  vfs_readv+0x69/0xb0
[    2.426977]  ? kmem_cache_free+0x7d/0x370
[    2.426978]  ? do_sys_openat2+0x1a2/0x2d0
[    2.426978]  do_readv+0x66/0x110
[    2.426979]  do_syscall_64+0x33/0x80
[    2.426980]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.426980] RIP: 0033:0x22c483
[    2.426981] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    2.426981] RSP: 002b:00007fffa68e3ba0 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    2.426982] RAX: ffffffffffffffda RBX: 0000000001a94b00 RCX: 000000000022c483
[    2.426982] RDX: 0000000000000002 RSI: 00007fffa68e3ba0 RDI: 0000000000000010
[    2.426982] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    2.426983] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001a94b00
[    2.426983] R13: 00007fffa68e3ce8 R14: 0000000000000001 R15: 00007fffa68e3be7
[    2.426984] ---[ end trace b52c3dd5183e4b25 ]---
[    2.426984] odd readv on /9/mountinfo/

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_weird_readv.txt"

[    0.000000] Linux version 5.10.0-rc2-microsoft-00001-gd4d50710a8b4-dirty (nathan@Ryzen-9-3900X) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #12 SMP Sun Nov 15 14:30:26 MST 2020
[    0.000000] Kernel is locked down from Kernel configuration; see man kernel_lockdown.7
[    0.000000] Command line: initrd=\initrd.img panic=-1 pty.legacy_count=0 nr_cpus=24
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000e0fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000001fffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000000200000-0x00000000f7ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000407ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI not present or invalid.
[    0.000000] Hypervisor detected: Microsoft Hyper-V
[    0.000000] Hyper-V: features 0xae7f, hints 0xc2c, misc 0x20bed7b2
[    0.000000] Hyper-V Host Build:19041-10.0-0-0.630
[    0.000000] Hyper-V: LAPIC Timer Frequency: 0x1e8480
[    0.000000] Hyper-V: Using hypercall for remote TLB flush
[    0.000000] clocksource: hyperv_clocksource_tsc_page: mask: 0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000001] tsc: Detected 3800.009 MHz processor
[    0.000004] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000005] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000007] last_pfn = 0x408000 max_arch_pfn = 0x400000000
[    0.000028] MTRR default type: uncachable
[    0.000028] MTRR fixed ranges disabled:
[    0.000029]   00000-FFFFF uncachable
[    0.000029] MTRR variable ranges disabled:
[    0.000029]   0 disabled
[    0.000029]   1 disabled
[    0.000030]   2 disabled
[    0.000030]   3 disabled
[    0.000030]   4 disabled
[    0.000030]   5 disabled
[    0.000030]   6 disabled
[    0.000031]   7 disabled
[    0.000031] Disabled
[    0.000031] x86/PAT: MTRRs disabled, skipping PAT initialization too.
[    0.000037] CPU MTRRs all blank - virtualized system.
[    0.000038] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.000040] last_pfn = 0xf8000 max_arch_pfn = 0x400000000
[    0.000047] Using GB pages for direct mapping
[    0.000138] RAMDISK: [mem 0x02f70000-0x02f7ffff]
[    0.000140] ACPI: Early table checksum verification disabled
[    0.000141] ACPI: RSDP 0x00000000000E0000 000024 (v02 VRTUAL)
[    0.000144] ACPI: XSDT 0x0000000000100000 000044 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000147] ACPI: FACP 0x0000000000101000 000114 (v06 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000150] ACPI: DSDT 0x00000000001011B8 01E184 (v02 MSFTVM DSDT01   00000001 MSFT 05000000)
[    0.000151] ACPI: FACS 0x0000000000101114 000040
[    0.000152] ACPI: OEM0 0x0000000000101154 000064 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000154] ACPI: SRAT 0x000000000011F33C 000390 (v02 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000155] ACPI: APIC 0x000000000011F6CC 000108 (v04 VRTUAL MICROSFT 00000001 MSFT 00000001)
[    0.000158] ACPI: Local APIC address 0xfee00000
[    0.000344] Zone ranges:
[    0.000344]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000346]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000346]   Normal   [mem 0x0000000100000000-0x0000000407ffffff]
[    0.000347] Movable zone start for each node
[    0.000347] Early memory node ranges
[    0.000348]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.000348]   node   0: [mem 0x0000000000200000-0x00000000f7ffffff]
[    0.000349]   node   0: [mem 0x0000000100000000-0x0000000407ffffff]
[    0.000498] Zeroed struct page in unavailable ranges: 353 pages
[    0.000500] Initmem setup node 0 [mem 0x0000000000001000-0x0000000407ffffff]
[    0.000500] On node 0 totalpages: 4193951
[    0.000501]   DMA zone: 59 pages used for memmap
[    0.000501]   DMA zone: 22 pages reserved
[    0.000502]   DMA zone: 3743 pages, LIFO batch:0
[    0.000517]   DMA32 zone: 16320 pages used for memmap
[    0.000518]   DMA32 zone: 1011712 pages, LIFO batch:63
[    0.009416]   Normal zone: 49664 pages used for memmap
[    0.009418]   Normal zone: 3178496 pages, LIFO batch:63
[    0.009765] ACPI: Local APIC address 0xfee00000
[    0.009770] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.010053] IOAPIC[0]: apic_id 24, version 17, address 0xfec00000, GSI 0-23
[    0.010056] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.010057] ACPI: IRQ9 used by override.
[    0.010058] Using ACPI (MADT) for SMP configuration information
[    0.010063] smpboot: Allowing 24 CPUs, 0 hotplug CPUs
[    0.010070] [mem 0xf8000000-0xffffffff] available for PCI devices
[    0.010070] Booting paravirtualized kernel on Hyper-V
[    0.010072] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.013364] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:24 nr_node_ids:1
[    0.014266] percpu: Embedded 41 pages/cpu s135192 r0 d32744 u262144
[    0.014270] pcpu-alloc: s135192 r0 d32744 u262144 alloc=1*2097152
[    0.014271] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.014275] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 
[    0.014284] Built 1 zonelists, mobility grouping on.  Total pages: 4127886
[    0.014285] Kernel command line: initrd=\initrd.img panic=-1 pty.legacy_count=0 nr_cpus=24
[    0.014314] printk: log_buf_len individual max cpu contribution: 262144 bytes
[    0.014315] printk: log_buf_len total cpu_extra contributions: 6029312 bytes
[    0.014315] printk: log_buf_len min size: 262144 bytes
[    0.021451] printk: log_buf_len: 8388608 bytes
[    0.021452] printk: early log buf free: 256264(97%)
[    0.023711] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.024784] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.024838] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.039780] Memory: 4126944K/16775804K available (14341K kernel code, 1480K rwdata, 2448K rodata, 916K init, 1484K bss, 422372K reserved, 0K cma-reserved)
[    0.039785] random: get_random_u64 called from __kmem_cache_create+0x29/0x3b0 with crng_init=0
[    0.039872] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=1
[    0.040089] rcu: Hierarchical RCU implementation.
[    0.040090] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=24.
[    0.040091] 	Tracing variant of Tasks RCU enabled.
[    0.040091] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.040091] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=24
[    0.040099] Using NULL legacy PIC
[    0.040100] NR_IRQS: 16640, nr_irqs: 616, preallocated irqs: 0
[    0.040449] random: crng done (trusting CPU's manufacturer)
[    0.040476] printk: console [ttyS0] enabled
[    0.040480] ACPI: Core revision 20200925
[    0.040584] Failed to register legacy timer interrupt
[    0.040585] APIC: Switch to symmetric I/O mode setup
[    0.040586] Switched APIC routing to physical flat.
[    0.040606] Hyper-V: Using IPI hypercalls
[    0.040606] Hyper-V: Using enlightened APIC (xapic mode)
[    0.040675] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6d8cc2767c9, max_idle_ns: 881590832756 ns
[    0.040678] Calibrating delay loop (skipped), value calculated using timer frequency.. 7600.01 BogoMIPS (lpj=38000090)
[    0.040679] pid_max: default: 32768 minimum: 301
[    0.040702] LSM: Security Framework initializing
[    0.040705] Yama: becoming mindful.
[    0.040707] LoadPin: ready to pin (currently enforcing)
[    0.040734] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.040753] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.040971] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.040988] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.040988] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.040990] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.040991] Spectre V2 : Mitigation: Full AMD retpoline
[    0.040991] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.040992] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.040992] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.040993] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.041099] Freeing SMP alternatives memory: 48K
[    0.041147] smpboot: CPU0: AMD Ryzen 9 3900X 12-Core Processor (family: 0x17, model: 0x71, stepping: 0x0)
[    0.041195] Performance Events: PMU not available due to virtualization, using software events only.
[    0.041294] rcu: Hierarchical SRCU implementation.
[    0.041551] smp: Bringing up secondary CPUs ...
[    0.041583] x86: Booting SMP configuration:
[    0.041584] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.051186] smp: Brought up 1 node, 24 CPUs
[    0.051186] smpboot: Max logical packages: 1
[    0.051186] smpboot: Total of 24 processors activated (182400.43 BogoMIPS)
[    0.064465] node 0 deferred pages initialised in 10ms
[    0.064488] devtmpfs: initialized
[    0.064488] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.064488] futex hash table entries: 8192 (order: 7, 524288 bytes, linear)
[    0.065349] NET: Registered protocol family 16
[    0.070704] ACPI: bus type PCI registered
[    0.070712] PCI: Fatal: No config space access function found
[    0.071622] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.071622] raid6: skip pq benchmark and using algorithm avx2x4
[    0.071622] raid6: using avx2x2 recovery algorithm
[    0.071622] ACPI: Added _OSI(Module Device)
[    0.071622] ACPI: Added _OSI(Processor Device)
[    0.071622] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.071622] ACPI: Added _OSI(Processor Aggregator Device)
[    0.071622] ACPI: Added _OSI(Linux-Dell-Video)
[    0.071622] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.071622] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.074612] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.080702] ACPI: Interpreter enabled
[    0.080705] ACPI: (supports S0 S5)
[    0.080705] ACPI: Using IOAPIC for interrupt routing
[    0.080710] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.080837] ACPI: Enabled 1 GPEs in block 00 to 0F
[    0.081852] iommu: Default domain type: Translated 
[    0.081897] SCSI subsystem initialized
[    0.081967] hv_vmbus: Vmbus version:5.2
[    0.081967] PCI: Using ACPI for IRQ routing
[    0.081967] PCI: System does not support PCI
[    0.081967] clocksource: Switched to clocksource tsc-early
[    0.081967] hv_vmbus: Unknown GUID: c376c1c3-d276-48d2-90a9-c04748072c60
[    0.081967] VFS: Disk quotas dquot_6.6.0
[    0.081967] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.081967] FS-Cache: Loaded
[    0.081967] pnp: PnP ACPI init
[    0.081967] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.081967] pnp: PnP ACPI: found 1 devices
[    0.081967] NET: Registered protocol family 2
[    0.081990] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.082002] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.082101] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.082335] TCP: Hash tables configured (established 131072 bind 65536)
[    0.082365] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.082388] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.082443] NET: Registered protocol family 1
[    0.082706] RPC: Registered named UNIX socket transport module.
[    0.082707] RPC: Registered udp transport module.
[    0.082707] RPC: Registered tcp transport module.
[    0.082707] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.082709] PCI: CLS 0 bytes, default 64
[    0.082729] Trying to unpack rootfs image as initramfs...
[    0.082851] Freeing initrd memory: 64K
[    0.082852] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.082854] software IO TLB: mapped [mem 0x00000000f4000000-0x00000000f8000000] (64MB)
[    0.084486] kvm: no hardware support
[    0.084487] has_svm: svm not available
[    0.084488] kvm: no hardware support
[    0.087104] Initialise system trusted keyrings
[    0.087201] workingset: timestamp_bits=46 max_order=22 bucket_order=0
[    0.088050] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.088489] NFS: Registering the id_resolver key type
[    0.088498] Key type id_resolver registered
[    0.088499] Key type id_legacy registered
[    0.088501] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    0.090055] Key type cifs.idmap registered
[    0.090101] fuse: init (API version 7.32)
[    0.090220] SGI XFS with ACLs, security attributes, realtime, scrub, repair, quota, no debug enabled
[    0.091628] 9p: Installing v9fs 9p2000 file system support
[    0.091635] FS-Cache: Netfs '9p' registered for caching
[    0.091965] FS-Cache: Netfs 'ceph' registered for caching
[    0.091967] ceph: loaded (mds proto 32)
[    0.094463] NET: Registered protocol family 38
[    0.094464] xor: automatically using best checksumming function   avx       
[    0.094465] Key type asymmetric registered
[    0.094466] Asymmetric key parser 'x509' registered
[    0.094470] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.095316] hv_vmbus: registering driver hv_pci
[    0.095512] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.095777] Non-volatile memory driver v1.3
[    0.098766] brd: module loaded
[    0.099620] loop: module loaded
[    0.099904] hv_vmbus: registering driver hv_storvsc
[    0.100197] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
[    0.100198] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[    0.100208] tun: Universal TUN/TAP device driver, 1.6
[    0.100287] PPP generic driver version 2.4.2
[    0.100367] PPP BSD Compression module registered
[    0.100369] PPP Deflate Compression module registered
[    0.100373] PPP MPPE Compression module registered
[    0.100374] NET: Registered protocol family 24
[    0.100383] hv_vmbus: registering driver hv_netvsc
[    0.101145] scsi host0: storvsc_host_t
[    0.112141] VFIO - User Level meta-driver version: 0.3
[    0.112266] hv_vmbus: registering driver hyperv_keyboard
[    0.112418] rtc_cmos 00:00: RTC can wake from S4
[    0.113587] rtc_cmos 00:00: registered as rtc0
[    0.113905] rtc_cmos 00:00: setting system clock to 2020-11-15T21:31:09 UTC (1605475869)
[    0.113913] rtc_cmos 00:00: alarms up to one month, 114 bytes nvram
[    0.114010] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
[    0.114480] hv_utils: Registering HyperV Utility Driver
[    0.114481] hv_vmbus: registering driver hv_utils
[    0.114506] hv_vmbus: registering driver hv_balloon
[    0.114508] hv_utils: cannot register PTP clock: 0
[    0.114940] hv_utils: TimeSync IC version 4.0
[    0.115032] hv_balloon: Using Dynamic Memory protocol version 2.0
[    0.116121] Mirror/redirect action on
[    0.116464] IPVS: Registered protocols (TCP, UDP)
[    0.116479] IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
[    0.116503] IPVS: ipvs loaded.
[    0.116503] IPVS: [rr] scheduler registered.
[    0.116504] IPVS: [wrr] scheduler registered.
[    0.116504] IPVS: [sh] scheduler registered.
[    0.118083] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[    0.118578] Initializing XFRM netlink socket
[    0.118639] NET: Registered protocol family 10
[    0.119187] Segment Routing with IPv6
[    0.120534] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.120600] NET: Registered protocol family 17
[    0.120616] Bridge firewalling registered
[    0.120621] 8021q: 802.1Q VLAN Support v1.8
[    0.120639] sctp: Hash tables configured (bind 256/256)
[    0.120764] 9pnet: Installing 9P2000 support
[    0.120776] Key type dns_resolver registered
[    0.120776] Key type ceph registered
[    0.121325] libceph: loaded (mon/osd proto 15/24)
[    0.121378] NET: Registered protocol family 40
[    0.121379] hv_vmbus: registering driver hv_sock
[    0.121674] IPI shorthand broadcast: enabled
[    0.121679] sched_clock: Marking stable (121049985, 315500)->(126847900, -5482415)
[    0.121932] registered taskstats version 1
[    0.121933] Loading compiled-in X.509 certificates
[    0.121963] Key type ._fscrypt registered
[    0.121964] Key type .fscrypt registered
[    0.121965] Key type fscrypt-provisioning registered
[    0.122157] Btrfs loaded, crc32c=crc32c-generic
[    0.122845] Freeing unused kernel image (initmem) memory: 916K
[    0.180739] Write protecting the kernel read-only data: 20480k
[    0.181561] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    0.181956] Freeing unused kernel image (rodata/data gap) memory: 1648K
[    0.204771] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.204775] Run /init as init process
[    0.204775]   with arguments:
[    0.204776]     /init
[    0.204776]   with environment:
[    0.204776]     HOME=/
[    0.204776]     TERM=linux
[    0.219016] scsi 0:0:0:0: Direct-Access     Msft     Virtual Disk     1.0  PQ: 0 ANSI: 5
[    0.219293] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    0.219997] sd 0:0:0:0: [sda] 536870912 512-byte logical blocks: (275 GB/256 GiB)
[    0.219999] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    0.220082] sd 0:0:0:0: [sda] Write Protect is off
[    0.220083] sd 0:0:0:0: [sda] Mode Sense: 0f 00 00 00
[    0.220265] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.530848] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.533617] EXT4-fs (sda): mounted filesystem with ordered data mode. Opts: discard,errors=remount-ro,data=ordered
[    1.150719] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6d8cc2767c9, max_idle_ns: 881590832756 ns
[    1.150729] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    1.151485] clocksource: Switched to clocksource tsc
[    2.474733] FS-Cache: Duplicate cookie detected
[    2.474736] FS-Cache: O-cookie c=000000003aa1b52c [p=000000003bf9f9f6 fl=222 nc=0 na=1]
[    2.474736] FS-Cache: O-cookie d=000000005eb501fe n=00000000ec8edf86
[    2.474737] FS-Cache: O-key=[10] '34323934393337353430'
[    2.474740] FS-Cache: N-cookie c=000000003afa08ab [p=000000003bf9f9f6 fl=2 nc=0 na=1]
[    2.474740] FS-Cache: N-cookie d=000000005eb501fe n=00000000e3eb10ea
[    2.474740] FS-Cache: N-key=[10] '34323934393337353430'
[    2.494684] [init]: weird readv on 00000000e46ca6b2 (0) <0:1024> -> 1024
[    2.494713] [init]: weird readv on 00000000e46ca6b2 (1024) <0:1024> -> -14
[    2.494717] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.494721] init: (9) ERROR: CreateProcessParseCommon:849: Failed to translate C:\Users\natec

[    2.494731] [init]: weird readv on 000000000def1a78 (0) <0:1024> -> 1024
[    2.494748] [init]: weird readv on 000000000def1a78 (1024) <0:1024> -> -14
[    2.494750] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.494752] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows\system32

[    2.494754] [init]: weird readv on 000000007fc56802 (0) <0:1024> -> 1024
[    2.494769] [init]: weird readv on 000000007fc56802 (1024) <0:1024> -> -14
[    2.494771] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.494772] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows
[    2.494774] [init]: weird readv on 000000008dfb23e5 (0) <0:1024> -> 1024
[    2.494788] [init]: weird readv on 000000008dfb23e5 (1024) <0:1024> -> -14
[    2.494790] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.494792] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows\System32\Wbem
[    2.494794] [init]: weird readv on 000000003f853dff (0) <0:1024> -> 1024
[    2.494808] [init]: weird readv on 000000003f853dff (1024) <0:1024> -> -14
[    2.494813] [init]: weird readv on 00000000be4c4ae7 (0) <0:1024> -> 1024
[    2.494827] [init]: weird readv on 00000000be4c4ae7 (1024) <0:1024> -> -14
[    2.494831] [init]: weird readv on 000000006f17c3b7 (0) <0:1024> -> 1024
[    2.494845] [init]: weird readv on 000000006f17c3b7 (1024) <0:1024> -> -14
[    2.494850] [init]: weird readv on 0000000076f319bd (0) <0:1024> -> 1024
[    2.494863] [init]: weird readv on 0000000076f319bd (1024) <0:1024> -> -14
[    2.494868] [init]: weird readv on 000000005223b955 (0) <0:1024> -> 1024
[    2.494882] [init]: weird readv on 000000005223b955 (1024) <0:1024> -> -14
[    2.494886] [init]: weird readv on 00000000b937c5ad (0) <0:1024> -> 1024
[    2.494900] [init]: weird readv on 00000000b937c5ad (1024) <0:1024> -> -14
[    2.494904] [init]: weird readv on 000000009eb66126 (0) <0:1024> -> 1024
[    2.494918] [init]: weird readv on 000000009eb66126 (1024) <0:1024> -> -14
[    2.494923] [init]: weird readv on 0000000085371084 (0) <0:1024> -> 1024
[    2.494937] [init]: weird readv on 0000000085371084 (1024) <0:1024> -> -14

--HlL+5n6rz5pIUxbD--
