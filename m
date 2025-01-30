Return-Path: <linux-fsdevel+bounces-40439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB52FA23651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366FA167272
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779D1F12F6;
	Thu, 30 Jan 2025 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S2FDpeW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AA1EF09C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271168; cv=none; b=mRDDZrCP+2YRm5vvWERRPQCRTHkg0StJlRjk1dxxiqAiZ2vI54ntuc+eKyMfS9nYff0qWsOeDivFgVFkhIHt73WjMaJ0j+nX4BNc0drViOGTMl4gitpLnbihZ2c0WZAI0CuKFUdLb91dqkNNQkQ5XIDW6SFjZqBHP88lMVQmzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271168; c=relaxed/simple;
	bh=OL48AjWgPca1qpR+kW+bsAv3I245rdLzl9l0Juze94M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQE2GDWpi9Gk8J8qo5ED4wmjPQr4m031Le3Y4OC07Smq7H7P55/pvA7A0lDRmqP1hbiyqVp3bsJoDvijD5KChS7ZjbskBgEM8pVBIg6TI+QuhOri5wMlYrjsMq0NKURxpD6mSLxbeS/jIKwaNqG3WoI2OGn+02q2CzPWrfhMbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S2FDpeW7; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f44113c101so3812667b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 13:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738271164; x=1738875964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0tKV1aO06e/O0OrbzjacFwylG9jIZZkGMi9QwaFoQw=;
        b=S2FDpeW7+z/j6/OenaMTNETnQ8MjSchE1G5ysgdUiL77d1GrOdBQxPCBNu2Ghs7XWJ
         nlu/YYW/fJG/T2WqrqcqaCee4tdDrXiEDhPI2E9UvA62dYsLhvZaqnKdFbYap+93M6Q7
         6uagKxy5KshP4QvqgFW8qtcPFvhbftMT/SYYwk6Y2hHg3EZUPwPvcXoTyw8Xu/q563ZH
         KNQIEE1C+jjx+ZRS6bEjxm/++HpKIk+JUFbmFdnydwjBQ9N0wJZLNYQTh4KCkEG3uX+D
         icaP+DZt69ln8i7P0bsKNDjmU5nL3mE4iAP9cEIn9NQL13U5BK0fLKyHv2IlHe4DXigH
         sEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271165; x=1738875965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0tKV1aO06e/O0OrbzjacFwylG9jIZZkGMi9QwaFoQw=;
        b=QfQVmUPDPIsYwIyNLPQw/QbO0mGAsbqxpifSBd30yWOcB2wAlLn+2tCIa/bKv1Yl4J
         i7QSr97085Fb3NQqdAt80SVEJm5q9WV9D50QGjnMef59waEWfz52vxWJhN6J75U7A5TE
         PexQHyma6CQ+7thIXYUK8ZzFJHEJtK67GAKknY+oWmJ7/zfqguBRDMfVLlN3HMcDy1GC
         dRfDcIWxnRCziSRJGcniWvkbU41qdaegP8TIQcKvpkKizb9Duu4O1WypOrxK5Tb9p4ix
         4eKZzTirSDWoCmLyMBKayuksgS3aZiP/5KHKC6DKVUIUyyxQwvyUDIbBbSMzKCU8nmuv
         67uQ==
X-Gm-Message-State: AOJu0Yx8e9j9JXP95Hif1bHcAUKPH3UO/ZEhgr4pT7CnpHHFJT5Acd2m
	PEg4eBLjFMP/jS0JkNeA1k+F6dL1C5NFpec5Qc8/MGOFbxArKAxRfYDKPGMuSRDgTL0K4s7nljD
	R4CaS0nYIc6sVNWWm41c9PFJH7REFtgNyOyfw
X-Gm-Gg: ASbGncs6hrUoLGmIYAV7PqPzzAaOLPiHsSuPxHPnHmL8pDGgoTv7Yd7/9O7UAKp7Y+N
	URBQKPw/poeqVSsM+clOP9KiVaNGmjAkdZ81oKW4FeZb2L8dH+ZkUsDjRRQm+IK/gmzQd1gg=
X-Google-Smtp-Source: AGHT+IH+ckwfvZFjliyWvxAApv5Gvw35jbwVywAqbuEKp/REwr8ScUlmNPXqS/akwDlB60L/XLa+LIC+kidTyTg8nGE=
X-Received: by 2002:a05:690c:6602:b0:6ef:4a57:fc98 with SMTP id
 00721157ae682-6f7a8354df6mr74999037b3.16.1738271164623; Thu, 30 Jan 2025
 13:06:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
In-Reply-To: <20250129165803.72138-3-mszeredi@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Jan 2025 16:05:53 -0500
X-Gm-Features: AWEUYZkqXlCOfnnMA-0yOjXYsL2G1YyD1829MDG4OZWumGa043Y7iRqeD-zMfbY
Message-ID: <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 11:58=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> Add notifications for attaching and detaching mounts.  The following new
> event masks are added:
>
>   FAN_MNT_ATTACH  - Mount was attached
>   FAN_MNT_DETACH  - Mount was detached
>
> If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> FAN_MNT_DETACH).
>
> These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containin=
g
> these fields identifying the affected mounts:
>
>   __u64 mnt_id    - the ID of the mount (see statmount(2))
>
> FAN_REPORT_MNT must be supplied to fanotify_init() to receive these event=
s
> and no other type of event can be received with this report type.
>
> Marks are added with FAN_MARK_MNTNS, which records the mount namespace fr=
om
> an nsfs file (e.g. /proc/self/ns/mnt).
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/mount.h                         |  2 +
>  fs/namespace.c                     | 14 +++--
>  fs/notify/fanotify/fanotify.c      | 38 +++++++++++--
>  fs/notify/fanotify/fanotify.h      | 18 +++++++
>  fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++++-----
>  fs/notify/fdinfo.c                 |  5 ++
>  include/linux/fanotify.h           | 12 +++--
>  include/uapi/linux/fanotify.h      | 10 ++++
>  security/selinux/hooks.c           |  4 ++
>  9 files changed, 167 insertions(+), 23 deletions(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7b867dfec88b..06d073eab53c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *=
path, u64 mask,
>         case FSNOTIFY_OBJ_TYPE_INODE:
>                 perm =3D FILE__WATCH;
>                 break;
> +       case FSNOTIFY_OBJ_TYPE_MNTNS:
> +               /* Maybe introduce FILE__WATCH_MOUNTNS? */
> +               perm =3D FILE__WATCH_MOUNT;
> +               break;
>         default:
>                 return -EINVAL;
>         }

Ignoring for a moment that this patch was merged without an explicit
ACK for the SELinux changes, let's talk about these SELinux changes
...

I understand that you went with the "simpler version" because you
didn't believe the discussion was converging, which is fair, however,
I believe Daniel's argument is convincing enough to warrant the new
permission.  Yes, it has taken me approximately two days to find the
time to revisit this topic and reply with some clarity, but personally
I feel like that is not an unreasonable period of time, especially for
a new feature discussion occurring during the merge window.

If you need an example on how to add a new SELinux permission, you can
look at commit ed5d44d42c95 ("selinux: Implement userns_create hook")
for a fairly simple example.  In the watch_mountns case things are
slightly different due to the existence of the COMMON_FILE_PERMS
macro, but you basically want to add "watch_mountns" to the end of the
COMMON_FILE_PERMS macro in security/selinux/include/classmap.h.  Of
course if you aren't sure about something, let me know.  As a FYI, my
network access will be spotty starting tonight and extending through
the weekend, but I will have network/mail access at least once a day.

Now back to the merge into the VFS tree ... I was very surprised to
open this patchset and see that Christian had merged v5 after less
than 24 hours (at least according to the email timestamps that I see)
and without an explicit ACK for the SELinux changes.  I've mentioned
this to you before Christian, please do not merge any SELinux, LSM
framework, or audit related patches without an explicit ACK.  I
recognize that sometimes there are highly critical security issues
that need immediate attention, but that is clearly not the case here,
and there are other procedures to help deal with those emergency
scenarios.

--=20
paul-moore.com

