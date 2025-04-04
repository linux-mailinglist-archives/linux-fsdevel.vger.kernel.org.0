Return-Path: <linux-fsdevel+bounces-45745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA0EA7BA70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E377A7153
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC191B0F31;
	Fri,  4 Apr 2025 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwxFxrkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95C188CB1
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761445; cv=none; b=OAakl+Q1rUjGvXnqDRuwoNPAIpGhPLN98tn2ciCemjV8Qt5bqO6v97tKNiK2wsNdF0oQlDEhw2E9aSnWbuo/jof9hhE8HibPkaDMmqt98GjVTCGp55Hwt4gHbquyKKK0+S93DLGjMA+77yC2cRwdMy18ar8VDfxhRoEbzBfZPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761445; c=relaxed/simple;
	bh=7TN2xKokra0Co3+U5mHRojMhA8uKTFn+eNeDef4ckqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLyXmw3I7B9N9Rnacd8aTmh9acFdzK2YvoTrn6AjTjA+fwFgIyCYhFCXtrcvVTRFfW/pjg02xxnBjXxJyC1kp8Cw9QJ4RqMw2M9tgBcCzIX6Zo1R4sAEu6n8pdRDB05vLN1+qc8LsLyNgYrhdkwsHzh+qp+8CKDm5U1AgALKYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwxFxrkZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so3014709a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 03:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743761442; x=1744366242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j39rcrQQX7VYAbWj/7FGeUOEXUr2kSkns//tDQI0+8=;
        b=SwxFxrkZ7qhLmXTZdAUWE605z00jGinK6DiB69TMUhAiLMJ2bzzzzdsnz3rNKtlg4t
         Rh54yFxacBvBOC5rq7ldYgsUC/cH7ijagp7Sv/ClHtTWGRyk+SuADVL7ypUEg496ItHP
         p3Po7O+Y9nsGj5tEMEizPOxHSBEHJw30iRK2ZCqrLC8IJsuGUUwrUxv5Pl3gatAqQutq
         2GEJ1C4KtNnbKd++3cMIUCljVg7rvFAP3rZPIDqr7y2Mpcok7wlau/Q78pmOEuA62xkL
         Vkdjvj1IQ0JL2Dl/YXOAKXNQt6X6kVnj9vNAGQUMAkiOLVOMuvOoyAAOOMJnJqKdafRg
         UJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743761442; x=1744366242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j39rcrQQX7VYAbWj/7FGeUOEXUr2kSkns//tDQI0+8=;
        b=dJ9fnMCtbMfvijG4XCtD9vGpwqymPa+23wCaqav3NlnZCW4kbNrZUoE1H7fignuINW
         hMgc/ZMA1kEQsAdPdiReslipME4S4FqAqN1qgDIw0gsDjEVicwwaE7626gjjJynu5Efl
         9ewVtsnhjZDJ6qiPyWt6VDZ12j7O4q7bn96L90YphRp3LaZXZ9qtQoiKlL6yoRCq9XBz
         VbfbynDxu/bcm+gElxnufrwtqFqlwWA9JvYksUZyqLvLe3fDLod3Cz4bU+d/kgRVjBUD
         ftlMSEMEJg1QlboSwKbchIzIeAG+o0X78cezZw/yNR5+plksq4iP4LGuoaE5kTPv/xSa
         0m6w==
X-Forwarded-Encrypted: i=1; AJvYcCVo1zQMxo2WGfP/fW3SjPSzEA9+BzWKlCvcFcVyllAqbyC04+42zSroI+Uw8T1qGw1jkfwbpUpiOJxuGTOu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HgsZtcmUX70mg1HA+7dAPj06mYV5Nj8Ldzp1vRRLWQyPz0C2
	v5qXEFfcLIDlMxT70qrHUHihur1l8UiPkxuz31rC/za6OFehexIV5+e7HI32QjM6AE+TsaNWeiM
	4t++6Mxm6HgSvwxqXSXDYyLvxeOuXrzZnqmM=
X-Gm-Gg: ASbGncuLWg2iPZDJGsuFHNN//CwuxsTIhOF2CPpa7Grh13Yn7i7ZWFy6LJgtfhrG0R1
	QP62ML9Ajglc3i2u/hKAvjNI9GJILHfpD9l2n2Jloy0kwb/h7RrayONqLz48pyqqfVT88v77IC5
	BPZWEg3gfiz0ZK1ulXzaP0F+Otop+rlzMfqfVG
X-Google-Smtp-Source: AGHT+IFcUMstHuduU2FoXMzqplbezuSSgr6RsAw6knGEVVTR5nkxq4OtphHg8r+MysfG5q7YhSb+PyQx344LTYxUwuo=
X-Received: by 2002:a17:906:c153:b0:ac7:c73a:be40 with SMTP id
 a640c23a62f3a-ac7d1751be6mr236377566b.14.1743761441377; Fri, 04 Apr 2025
 03:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxi6PvAcT1vL0d0e+7YjvkfU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.com>
 <20250403180405.1326087-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250403180405.1326087-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Apr 2025 12:10:30 +0200
X-Gm-Features: ATxdqUEwq73WP_VphHJGrfO1lvTd_pdIOORW3Dw64JDADUImUhoE6i_tE_hmsFM
Message-ID: <CAOQ4uxgXO0XJzYmijXu=3yDF_hq3E1yPUxHqhwka19-_jeaNFA@mail.gmail.com>
Subject: Re: Reseting pending fanotify events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 8:04=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.c=
om> wrote:
>
> > Let me list a few approaches to this problem that were floated in the p=
ast.
> > You may choose bits and parts that you find useful to your use case.
>
> Thanks for sharing these approaches for smoothly recovering pending event=
s.
>
> > 3. Change the default response to pending events on group fd close
> > Support writing a response with
> > .fd =3D FAN_NOFD
> > .response =3D FAN_DENY | FAN_DEFAULT
> > to set a group parameter fanotify_data.default_response.
>
> > Instead of setting pending events response to FAN_ALLOW,
> > could set it to FAN_DENY, or to descriptive error like
> > FAN_DENY(ECONNRESET).
>
>
> I think that the approach of customizing group close behavior would likel=
y
> address the problem of pending events in case of daemon restart / crash
> encountered by our use case. It gives us the same guarantee of clearing
> out pending event queue that we wanted while preventing any access of
> unpopulated content. The one ask related to this approach would be around
> the handover from old to new group fd. Would it be possible to provide an=
 easy
> way to initialize one group from another (ie an fanotify_mark option).
> In our case we have an interested mount as well as a set of ignore marks
> for populated files to avoid regenerating events for.
>

I think this case would be better handled by handing over the old fd to the
new server instance.

1. Start a new server instance
2. Set default response in case of new instance crash
3. Hand over a ref of the existing group fd to the new instance if the
old instance is running
4. Start handling events in new instance (*)
5. Stop handling new events in old instance, but complete pending events
6. Shutdown old instance

Is there some problem with that approach that I do not see?

(*) You have a multitude of choices on how to collaborate the
handover of event handling responsibilities from old to new server.
The handover can either be over a strong ordering barrier -
new start handling only after old completes pending,
or weaker ordering - old can start handling new events while
old is completing pending events.
In this case, you'd need some synchronization at file level (e.g. flock),
so the two instances will not try to populate the same file.

> The moderated mount functionality discussed in this thread would also be =
helpful
> for better handling when the daemon is down.

The terminology "moderated mount" freaks out some vfs maintainers ;)
So let me clarify what I think *might* be reasonable.
This untested sketch of a patch below demonstrates how we can use existing
fsnotify data structures to set up and implement a "moderated" sb.

There is currently no existing fanotify API to set this up, but it should
not be hard to implement such an API.

For example:

fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM | FAN_MARK_DEFAULT, ..=
.

I might have had some patches similar to this floating around.
If you are interested in this feature, I could write and test a proper patc=
h.

Doing this for the mount level would be possible, but TBH, it does not look
like the right object to be setting the moderation on, because even if we d=
id
set a default mask on a mount, it would have been easy to escape it by
creating a bind mount, cloning a new mount namespace, etc.

What is the reason that you are marking the mount?
Is it so that you could have another "unmoderated" mount to
populate the file conten?
In that case you can opt-in for permission events on sb
and opt-out from permission events on the "unmoderated" mount
and you can also populate the file content with the FMODE_NONOTIFY
fd provided in the permission event.

WDYT?

Thanks,
Amir.

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7b364f965650..9fc1235bbc47 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -585,7 +585,8 @@ int fsnotify(__u32 mask, const void *data, int
data_type, struct inode *dir,
         * SRCU because we have no references to any objects and do not
         * need SRCU to keep them "alive".
         */
-       if ((!sbinfo || !sbinfo->sb_marks) &&
+       if ((!sbinfo || (!sbinfo->sb_marks &&
+                        !READ_ONCE(sbinfo->default_mask))) &&
            (!mnt || !mnt->mnt_fsnotify_marks) &&
            (!inode || !inode->i_fsnotify_marks) &&
            (!inode2 || !inode2->i_fsnotify_marks) &&
@@ -641,6 +642,7 @@ int fsnotify(__u32 mask, const void *data, int
data_type, struct inode *dir,
         * ignore masks are properly reflected for mount/sb mark notificati=
ons.
         * That's why this traversal is so complicated...
         */
+       ret =3D 1;
        while (fsnotify_iter_select_report_types(&iter_info)) {
                ret =3D send_to_group(mask, data, data_type, dir, file_name=
,
                                    cookie, &iter_info);
@@ -650,6 +652,21 @@ int fsnotify(__u32 mask, const void *data, int
data_type, struct inode *dir,

                fsnotify_iter_next(&iter_info);
        }
+
+       /*
+        * The sb default mask has permission events and there currently no
+        * groups with marks handling permission events for this object.
+        * That could mean that an "access modertating" service was stopped
+        * or died without the chance or desire to allow sb access.
+        * Err on the side of caution and deny access until another access
+        * moderating service has started.
+        */
+       if (ret > 0 && (mask & ALL_FSNOTIFY_PERM_EVENTS) &&
+           sbinfo && (mask & READ_ONCE(sbinfo->default_mask))) {
+               ret =3D -EPERM;
+               goto out;
+       }
+
        ret =3D 0;
 out:
        srcu_read_unlock(&fsnotify_mark_srcu, iter_info.srcu_idx);
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 798340db69d7..317e21581e0a 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -255,6 +255,14 @@ static void *__fsnotify_recalc_mask(struct
fsnotify_mark_connector *conn)
                    !(mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
                        want_iref =3D true;
        }
+
+       if (conn->type =3D=3D FSNOTIFY_OBJ_TYPE_SB) {
+               struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
+
+               if (sbinfo)
+                       new_mask |=3D sbinfo->default_mask;
+       }
+
        /*
         * We use WRITE_ONCE() to prevent silly compiler optimizations from
         * confusing readers not holding conn->lock with partial updates.
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_back=
end.h
index 396943093373..476b506d6b4a 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -560,6 +560,7 @@ struct fsnotify_mark_connector {
  */
 struct fsnotify_sb_info {
        struct fsnotify_mark_connector __rcu *sb_marks;
+       __u32 default_mask;
        /*
         * Number of inode/mount/sb objects that are being watched in this =
sb.
         * Note that inodes objects are currently double-accounted.

