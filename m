Return-Path: <linux-fsdevel+bounces-33892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6279C038C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90AE1F241E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194CC1F5854;
	Thu,  7 Nov 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGdAbSJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7491F5837;
	Thu,  7 Nov 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977864; cv=none; b=Gjc1MIUcfl+IjQ/MYLgqB1AOwCvD5GIJbjd2z6+rNhYcgvhyfGMVnBOhBNSDMoaTH7MxeUguwF0JJE0tEOMqB6zXKCYTo2x/3m+CoTsNvYASkP5Ph1p6w4YAPHEtXf4FLuL4SPt1SKrcp1DcCN/CRbM39AChkUqOCP+lSX4ehE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977864; c=relaxed/simple;
	bh=jUOIWdGohf6sXZZrOk3s/1MfK4PkHnabVBj6RiVS/mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOXTCQfiVKjTkl3JNHQ8LTt7HgpBtoxMlFqZpxFf5GK/sv6uenW7ziEI71EuzDZlYTeC/UYsY0nRPp0ICG8oeXsjo3a3uudtPwMNjuIKZuLqp6IOSP7tLZP83VBX8cZ6opikcf9ajRaoD7baggyfmqitZsGXDSrboacxerVxPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGdAbSJe; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbd1ae26a6so5271916d6.1;
        Thu, 07 Nov 2024 03:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730977861; x=1731582661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfWovqbid7vxy+NP+yMUQ5ssiPzBBRzh2/IthvkJ3RI=;
        b=TGdAbSJeXHlI0mKQBfOhjuRkDvJMPhHoZlsx+n+8GEhEYVlgt/r9bE7iITM/L4lxxr
         s8y2rdsMXArXs1++Y32Ear7W30FHFo2BtqiFW+jtyTO4vFwtdyShkW7DrSBjEa/i69PX
         k9sUBDZ6wBoEjSIGjK/WAYRYhRdscJOrUbKpc+LnSDfhsmcUu+sQpo+h9JTj5Px/SFsZ
         WxfgXJ5x55xdxB9Om5oMiU5KAaxaUkPwDX8IMD/gaJcnnYIy3ACIxBvP4y0/DdZSzSXy
         xtrqHhWUSBoe7RofVotVwfcSx7mB/vFWqCTTfqUcvRKZj2+TfaXKMnIosFCTBG0F22cV
         IXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730977861; x=1731582661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfWovqbid7vxy+NP+yMUQ5ssiPzBBRzh2/IthvkJ3RI=;
        b=JZL5WEa1nDS3Nd8BjfnYkc9GpWxqiQNKM6wasoWs04sLSDbqCADNTkTMujUcS879UY
         OPxsin9Rtg8LYUwzjCwPzc4r0C7YKiCZNaYUykhpftd6gvmwxJgRcqQHkL5YET51VwdD
         GcSEa1pvOnOVAVoTQNLBLa1bqMrulhvIJtLytnlNVSClDurv2Kj/7qp+FjsaHj77jG7+
         zBnJw3M8vIkcKa5yI6EnpzNV9LbdEavRuMcNNRpBvedNGyDMdeGBHmWUIfUb4anmRlIN
         VzMdx8aAa+VRuVI0JXHNMqI1mDDF6c3jszOi69IbljJtMtH4Gc/Azq0CvC/tJMBKwouD
         UapA==
X-Forwarded-Encrypted: i=1; AJvYcCVqNQ6EwVVUaf8jj1cGUkSFx1fQNpBjgT/PInUhowYiTdirOj2WWio/+uHA/F7JZsMg8NFdl0V//AS9fzQ5@vger.kernel.org, AJvYcCXTaEuvGUEglvX1rr6vuGkc/5usdCBnY7yaqz8qiho9RHJwqZ5GdILCDv649hCEBWRBaIqA3RcZNY1uLs5H@vger.kernel.org
X-Gm-Message-State: AOJu0YxA/qNvt7rJN0ZbHtsUKiraCCgY0shgvs4tMyhqx074iJCrIElz
	Ia8SY5gbXLDdWzkzgIO48xsb33+AhRnopKPP6BXe/Qwpr5yRakVlSKKiF46k3sPAnl1xfnqdAPR
	/dfPyymXOh/T4E0fe/Q7nBBjjexo=
X-Google-Smtp-Source: AGHT+IFKKvEYUemv7HSVdb+OeV4PiJYe5MC24JfPwSuvWcgOh2aUC1lzUssEBSXaSKFv27AslbdiOvM4F/pLrNAUQzI=
X-Received: by 2002:a05:6214:468f:b0:6cb:dd09:7b54 with SMTP id
 6a1803df08f44-6d185674bd7mr526704746d6.6.1730977861145; Thu, 07 Nov 2024
 03:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029231244.2834368-1-song@kernel.org> <20241029231244.2834368-6-song@kernel.org>
In-Reply-To: <20241029231244.2834368-6-song@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Nov 2024 12:10:50 +0100
Message-ID: <CAOQ4uxjDudLwKuxXaFihdYJUv2yvwkETouP9zJtJ6bRSpmV-Kw@mail.gmail.com>
Subject: Re: [RFC bpf-next fanotify 5/5] selftests/bpf: Add test for BPF based
 fanotify fastpath handler
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, 
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 12:13=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> This test shows a simplified logic that monitors a subtree. This is
> simplified as it doesn't handle all the scenarios, such as:
>
>   1) moving a subsubtree into/outof the being monitoring subtree;

There is a solution for that (see below)

>   2) mount point inside the being monitored subtree

For that we will need to add the MOUNT/UNMOUNT/MOVE_MOUNT events,
but those have been requested by userspace anyway.

>
> Therefore, this is not to show a way to reliably monitor a subtree.
> Instead, this is to test the functionalities of bpf based fastpath.
> To really monitor a subtree reliably, we will need more complex logic.

Actually, this example is the foundation of my vision for efficient and rac=
e
free subtree filtering:

1. The inode map is to be treated as a cache for the is_subdir() query
2. Cache entries can also have a "distance from root" (i.e. depth) value
3. Each unknown queried path can call is_subdir() and populate the cache
    entries for all ancestors
4. The cache/map size should be limited and when limit is reached,
    evicting entries by depth priority makes sense
5. A rename event for a directory whose inode is in the map and whose
   new parent is not in the map or has a different value than old parent
   needs to invalidate the entire map
6. fast_path also needs a hook from inode evict to clear cache entries

This is similar, but more efficient and race free than what could already
be achieved in userspace using FAN_MARK_EVICTABLE.

Food for thought.

Thanks,
Amir.

>
> Overview of the logic:
>   1. fanotify is created for the whole file system (/tmp);
>   2. A bpf map (inode_storage_map) is used to tag directories to
>      monitor (starting from /tmp/fanotify_test);
>   3. On fsnotify_mkdir, thee tag is propagated to newly created sub
>      directories (/tmp/fanotify_test/subdir);
>   4. The bpf fastpath checks whether the fanotify event happens in a
>      directory with the tag. If yes, the event is sent to user space;
>      otherwise, the event is dropped.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +
>  tools/testing/selftests/bpf/config            |   1 +
>  .../testing/selftests/bpf/prog_tests/fan_fp.c | 245 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/fan_fp.c    |  77 ++++++
>  4 files changed, 327 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fan_fp.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fan_fp.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index 2eb3483f2fb0..44dcf4991244 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -87,4 +87,8 @@ struct dentry;
>   */
>  extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name,
>                               struct bpf_dynptr *value_ptr) __ksym __weak=
;
> +
> +struct fanotify_fastpath_event;
> +extern struct inode *bpf_fanotify_data_inode(struct fanotify_fastpath_ev=
ent *event) __ksym __weak;
> +extern void bpf_iput(struct inode *inode) __ksym __weak;
>  #endif
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index 4ca84c8d9116..392cbcad8a8b 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -24,6 +24,7 @@ CONFIG_DEBUG_INFO_BTF=3Dy
>  CONFIG_DEBUG_INFO_DWARF4=3Dy
>  CONFIG_DUMMY=3Dy
>  CONFIG_DYNAMIC_FTRACE=3Dy
> +CONFIG_FANOTIFY=3Dy
>  CONFIG_FPROBE=3Dy
>  CONFIG_FTRACE_SYSCALLS=3Dy
>  CONFIG_FUNCTION_ERROR_INJECTION=3Dy
> diff --git a/tools/testing/selftests/bpf/prog_tests/fan_fp.c b/tools/test=
ing/selftests/bpf/prog_tests/fan_fp.c
> new file mode 100644
> index 000000000000..ea57ed366647
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/fan_fp.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#define _GNU_SOURCE
> +#include <err.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/fanotify.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +
> +#include <test_progs.h>
> +
> +#include "fan_fp.skel.h"
> +
> +#define TEST_FS "/tmp/"
> +#define TEST_DIR "/tmp/fanotify_test/"
> +
> +static int create_test_subtree(void)
> +{
> +       int err;
> +
> +       err =3D mkdir(TEST_DIR, 0777);
> +       if (err && errno !=3D EEXIST)
> +               return err;
> +
> +       return open(TEST_DIR, O_RDONLY);
> +}
> +
> +static int create_fanotify_fd(void)
> +{
> +       int fanotify_fd, err;
> +
> +       fanotify_fd =3D fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_NAME |=
 FAN_REPORT_DIR_FID,
> +                                   O_RDONLY);
> +
> +       if (!ASSERT_OK_FD(fanotify_fd, "fanotify_init"))
> +               return -1;
> +
> +       err =3D fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESY=
STEM,
> +                           FAN_CREATE | FAN_OPEN | FAN_ONDIR | FAN_EVENT=
_ON_CHILD,
> +                           AT_FDCWD, TEST_FS);
> +       if (!ASSERT_OK(err, "fanotify_mark")) {
> +               close(fanotify_fd);
> +               return -1;
> +       }
> +
> +       return fanotify_fd;
> +}
> +
> +static int attach_global_fastpath(int fanotify_fd)
> +{
> +       struct fanotify_fastpath_args args =3D {
> +               .name =3D "_tmp_test_sub_tree",
> +               .version =3D 1,
> +               .flags =3D 0,
> +       };
> +
> +       if (ioctl(fanotify_fd, FAN_IOC_ADD_FP, &args))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +#define EVENT_BUFFER_SIZE 4096
> +struct file_access_result {
> +       char name_prefix[16];
> +       bool accessed;
> +} access_results[3] =3D {
> +       {"aa", false},
> +       {"bb", false},
> +       {"cc", false},
> +};
> +
> +static void update_access_results(char *name)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < 3; i++) {
> +               if (strstr(name, access_results[i].name_prefix))
> +                       access_results[i].accessed =3D true;
> +       }
> +}
> +
> +static void parse_event(char *buffer, int len)
> +{
> +       struct fanotify_event_metadata *event =3D
> +               (struct fanotify_event_metadata *) buffer;
> +       struct fanotify_event_info_header *info;
> +       struct fanotify_event_info_fid *fid;
> +       struct file_handle *handle;
> +       char *name;
> +       int off;
> +
> +       for (; FAN_EVENT_OK(event, len); event =3D FAN_EVENT_NEXT(event, =
len)) {
> +               for (off =3D sizeof(*event) ; off < event->event_len;
> +                    off +=3D info->len) {
> +                       info =3D (struct fanotify_event_info_header *)
> +                               ((char *) event + off);
> +                       switch (info->info_type) {
> +                       case FAN_EVENT_INFO_TYPE_DFID_NAME:
> +                               fid =3D (struct fanotify_event_info_fid *=
) info;
> +                               handle =3D (struct file_handle *)&fid->ha=
ndle;
> +                               name =3D (char *)handle + sizeof(*handle)=
 + handle->handle_bytes;
> +                               update_access_results(name);
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +               }
> +       }
> +}
> +
> +static void touch_file(const char *path)
> +{
> +       int fd;
> +
> +       fd =3D open(path, O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, 0666);
> +       if (!ASSERT_OK_FD(fd, "open"))
> +               goto cleanup;
> +       close(fd);
> +cleanup:
> +       unlink(path);
> +}
> +
> +static void generate_and_test_event(int fanotify_fd)
> +{
> +       char buffer[EVENT_BUFFER_SIZE];
> +       int len, err;
> +
> +       /* access /tmp/fanotify_test/aa, this will generate event */
> +       touch_file(TEST_DIR "aa");
> +
> +       /* create /tmp/fanotify_test/subdir, this will get tag from the
> +        * parent directory (added in the bpf program on fsnotify_mkdir)
> +        */
> +       err =3D mkdir(TEST_DIR "subdir", 0777);
> +       ASSERT_OK(err, "mkdir");
> +
> +       /* access /tmp/fanotify_test/subdir/bb, this will generate event =
*/
> +       touch_file(TEST_DIR "subdir/bb");
> +
> +       /* access /tmp/cc, this will NOT generate event, as the BPF
> +        * fastpath filtered this event out. (Because /tmp doesn't have
> +        * the tag.)
> +        */
> +       touch_file(TEST_FS "cc");
> +
> +       /* read and parse the events */
> +       len =3D read(fanotify_fd, buffer, EVENT_BUFFER_SIZE);
> +       if (!ASSERT_GE(len, 0, "read event"))
> +               goto cleanup;
> +       parse_event(buffer, len);
> +
> +       /* verify we generated events for aa and bb, but filtered out the
> +        * event for cc.
> +        */
> +       ASSERT_TRUE(access_results[0].accessed, "access aa");
> +       ASSERT_TRUE(access_results[1].accessed, "access bb");
> +       ASSERT_FALSE(access_results[2].accessed, "access cc");
> +
> +cleanup:
> +       rmdir(TEST_DIR "subdir");
> +       rmdir(TEST_DIR);
> +}
> +
> +/* This test shows a simplified logic that monitors a subtree. This is
> + * simplified as it doesn't handle all the scenarios, such as:
> + *
> + *  1) moving a subsubtree into/outof the being monitoring subtree;
> + *  2) mount point inside the being monitored subtree
> + *
> + * Therefore, this is not to show a way to reliably monitor a subtree.
> + * Instead, this is to test the functionalities of bpf based fastpath.
> + *
> + * Overview of the logic:
> + * 1. fanotify is created for the whole file system (/tmp);
> + * 2. A bpf map (inode_storage_map) is used to tag directories to
> + *    monitor (starting from /tmp/fanotify_test);
> + * 3. On fsnotify_mkdir, thee tag is propagated to newly created sub
> + *    directories (/tmp/fanotify_test/subdir);
> + * 4. The bpf fastpath checks whether the event happens in a directory
> + *    with the tag. If yes, the event is sent to user space; otherwise,
> + *    the event is dropped.
> + */
> +static void test_monitor_subtree(void)
> +{
> +       struct bpf_link *link;
> +       struct fan_fp *skel;
> +       int test_root_fd;
> +       __u32 one =3D 1;
> +       int err, fanotify_fd;
> +
> +       test_root_fd =3D create_test_subtree();
> +
> +       if (!ASSERT_OK_FD(test_root_fd, "create_test_subtree"))
> +               return;
> +
> +       skel =3D fan_fp__open_and_load();
> +
> +       if (!ASSERT_OK_PTR(skel, "fan_fp__open_and_load"))
> +               goto close_test_root_fd;
> +
> +       /* Add tag to /tmp/fanotify_test/ */
> +       err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.inode_storage_=
map),
> +                                 &test_root_fd, &one, BPF_ANY);
> +       if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +               goto destroy_skel;
> +       link =3D bpf_map__attach_struct_ops(skel->maps.bpf_fanotify_fastp=
ath_ops);
> +       if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
> +               goto destroy_skel;
> +
> +
> +       fanotify_fd =3D create_fanotify_fd();
> +       if (!ASSERT_OK_FD(fanotify_fd, "create_fanotify_fd"))
> +               goto destroy_link;
> +
> +       err =3D attach_global_fastpath(fanotify_fd);
> +       if (!ASSERT_OK(err, "attach_global_fastpath"))
> +               goto close_fanotify_fd;
> +
> +       generate_and_test_event(fanotify_fd);
> +
> +       ASSERT_EQ(skel->bss->added_inode_storage, 1, "added_inode_storage=
");
> +
> +close_fanotify_fd:
> +       close(fanotify_fd);
> +
> +destroy_link:
> +       bpf_link__destroy(link);
> +destroy_skel:
> +       fan_fp__destroy(skel);
> +
> +close_test_root_fd:
> +       close(test_root_fd);
> +       rmdir(TEST_DIR);
> +}
> +
> +void test_bpf_fanotify_fastpath(void)
> +{
> +       if (test__start_subtest("subtree"))
> +               test_monitor_subtree();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fan_fp.c b/tools/testing/s=
elftests/bpf/progs/fan_fp.c
> new file mode 100644
> index 000000000000..ee86dc189e38
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fan_fp.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Facebook */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +#define FS_CREATE              0x00000100      /* Subfile was created */
> +#define FS_ISDIR               0x40000000      /* event occurred against=
 dir */
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, __u32);
> +} inode_storage_map SEC(".maps");
> +
> +int added_inode_storage;
> +
> +SEC("struct_ops")
> +int BPF_PROG(bpf_fp_handler,
> +            struct fsnotify_group *group,
> +            struct fanotify_fastpath_hook *fp_hook,
> +            struct fanotify_fastpath_event *fp_event)
> +{
> +       struct inode *dir;
> +       __u32 *value;
> +
> +       dir =3D fp_event->dir;
> +
> +       value =3D bpf_inode_storage_get(&inode_storage_map, dir, 0, 0);
> +
> +       /* if dir doesn't have the tag, skip the event */
> +       if (!value)
> +               return FAN_FP_RET_SKIP_EVENT;
> +
> +       /* propagate tag to subdir on fsnotify_mkdir */
> +       if (fp_event->mask =3D=3D (FS_CREATE | FS_ISDIR) &&
> +           fp_event->data_type =3D=3D FSNOTIFY_EVENT_DENTRY) {
> +               struct inode *new_inode;
> +
> +               new_inode =3D bpf_fanotify_data_inode(fp_event);
> +               if (!new_inode)
> +                       goto out;
> +
> +               value =3D bpf_inode_storage_get(&inode_storage_map, new_i=
node, 0,
> +                                             BPF_LOCAL_STORAGE_GET_F_CRE=
ATE);
> +               if (value) {
> +                       *value =3D 1;
> +                       added_inode_storage++;
> +               }
> +               bpf_iput(new_inode);
> +       }
> +out:
> +       return FAN_FP_RET_SEND_TO_USERSPACE;
> +}
> +
> +SEC("struct_ops")
> +int BPF_PROG(bpf_fp_init, struct fanotify_fastpath_hook *hook, const cha=
r *args)
> +{
> +       return 0;
> +}
> +
> +SEC("struct_ops")
> +void BPF_PROG(bpf_fp_free, struct fanotify_fastpath_hook *hook)
> +{
> +}
> +
> +SEC(".struct_ops.link")
> +struct fanotify_fastpath_ops bpf_fanotify_fastpath_ops =3D {
> +       .fp_handler =3D (void *)bpf_fp_handler,
> +       .fp_init =3D (void *)bpf_fp_init,
> +       .fp_free =3D (void *)bpf_fp_free,
> +       .name =3D "_tmp_test_sub_tree",
> +};
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.43.5
>

