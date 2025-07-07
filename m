Return-Path: <linux-fsdevel+bounces-54142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1DAFB8B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2610F3A9DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0851421E0BE;
	Mon,  7 Jul 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNOoJrWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979F72606
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906037; cv=none; b=gAni66YgYFIZt8Qp23JibHTRVebu4ghICMNsRBtYbzljYZiiW4LhqTTGCL63CwfxBXU/q5C7b/inwba/Px4QHPIWmm1svEa2TMzvWK2Yv+yk8VZb63k2x8TqIW7N7zkrClFN5MjEWaUgFocZKuhRxX0fMtpGzR54WEkGh4jMmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906037; c=relaxed/simple;
	bh=C4XZDj4mNEjRoT6za0k3NhvS1LbfXfuhUnhOuQSUp4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfCdkvQxULawko0IKgU5duQWlE6JsRkWkxh4AzKAWTxdS5HhRUmM80DSVmXh0zV0nRtvlPHLxw61mPrFMH/l2A/qYg4MOWr2rlaKnWjZCEP5FQGVe8n8CnZQ8DuIur9T71yEfAwmq24HwyWmchnDADIOsNwL2zpfqscAhO9zMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNOoJrWR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae361e8ec32so682516466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906033; x=1752510833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3lAzRlJ5HYbxoDmJxGphh/qlY2sbeo12KY4w59C9x0=;
        b=NNOoJrWRG7eC4REtHyq/Z5jsIq8zMUCs5V9mKzqdRU+V+r7pA8ufxMWEQ3p6P/xii9
         +K0GmrG/wg3ZwdUd+G40hyPlgM6ToyRq+O0K6tb80zaXBZflgOefgUQKsfqYno6xVJvp
         n4EYgrtuw0JSzJsi4sDJvBi8WQWX37eA+/W2Upa5nTEzODjCJ5SYTg2sdVpYfRrP5UpQ
         KGuGuGWhGCbeJ3M9A/pfRCoEuWUW6tE1g5ZFrWsVRKsJhdIjUAQv4fWR1eCHJ5K3NJUL
         HuS6X3Fui2kH+lt4y9dnxMihbxoxWLEmwJQ8I+H/inSWWkVsKRptVf5zJFJxYeQocwT6
         pPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906033; x=1752510833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3lAzRlJ5HYbxoDmJxGphh/qlY2sbeo12KY4w59C9x0=;
        b=DgJ2LKKvHo/Bgw3KMYNHxSUrXP5LDtrcL0Ww4WYNmOj15f/DC2lxbFHvWBCq5DQgyK
         E/rdB+b7te31+QwbJvfEI5Jg9T1JGdEidowBMZ+uRezrUr7GUwclXhJApO4MIemQDVOZ
         wKvoRhC94HKPc31ZESUr910vAQ3LETHr23wS+mD2EyyetJw/uGyY4T0lK5vwE4unUZQ+
         1X4sLKv2d51owCZlsUbjNk4B/Wr8O8aGlvezvqbs4njRsmiSfqb0j70eFF3VioCf2JiB
         JO97HXsE883HA+zxkEXcosByhfxcAILRDZ4VcDzPbW1/tBKN6/0FDe/TmU1Ez+aX9isZ
         Y/zA==
X-Forwarded-Encrypted: i=1; AJvYcCXgbM31WIEXdn8oAusQPHaIz4gGLFBz9gOE0X3/oEPnsUUeFm7UBuHv8P1UsKxeUwA6jUN+/76rBav4svFZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkcmD4gxGpD9OmzpGJA4fCD+TOuZ+BSkxPeJlR4VvaCJgnB7q
	Z+RiojgWYdRAfBZyw90/ig4DC2kVhOP6dmu5y9z2vKAeAI8u1fHxMeMThLnSFjnKtffMR7lKe6z
	D6NKQC1A4GsTmV3ETnL/zjyKWJ7wxzgw=
X-Gm-Gg: ASbGnctr2Mc2dB2wtVrjFBlk+yrEY5oF3X24rZI0IBu7cHlVTEvfZeOZ/PHUWiMVqHE
	qnCm4VExR0CMzUMJoh0GQNPC5P2iyvrokEz+GudCbubdXrHPhBhOW/G0AYkgnZF+zgC26cFIbkI
	D7folVW0YnW+34CgrL1rtL96r4rHik0nJJNa2vdPZDaXw=
X-Google-Smtp-Source: AGHT+IF2arsyYwuoh8CjBk/aDPZecFi2NepR+jFcUlbOsZtj/vTsWGLgcHvwKJNJo0zummYCxZh+IafItriKtIEXgLw=
X-Received: by 2002:a17:907:3f2a:b0:ae3:5e70:32f7 with SMTP id
 a640c23a62f3a-ae4108e5f74mr1000492066b.47.1751906032960; Mon, 07 Jul 2025
 09:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxi8xjfhKLc7T0WGjOmtO4wRQT6b5MLUdaST2KE01BsKBg@mail.gmail.com>
 <20250701072209.1549495-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250701072209.1549495-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Jul 2025 18:33:41 +0200
X-Gm-Features: Ac12FXyXQ1Ft3d82tFWthAW9LB_sE-UZn8TrQ11EOQ1sa0KkfwzunMBUwcDVk90
Message-ID: <CAOQ4uxhrbN4k+YMd99h8jGyRc0d_n05H8q-gTuJ35jkO1aLO7A@mail.gmail.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 9:23=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.c=
om> wrote:
>
> On 6/30/25, 9:06 AM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73i=
l@gmail.com>> wrote:
> > On Mon, Jun 30, 2025 at 4:50=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hi!
> > >
> > > I agree expanding fanotify_event_metadata painful. After all that's t=
he
> > > reason why we've invented the additional info records in the first pl=
ace :).
> > > So I agree with putting the id either in a separate info record or ov=
erload
> > > something in fanotify_event_metadata.
> > >
> > > On Sun 29-06-25 08:50:05, Amir Goldstein wrote:
> > > > I may have mentioned this before, but I'll bring it up again.
> > > > If we want to overload event->fd with response id I would consider
> > > > allocating response_id with idr_alloc_cyclic() that starts at 256
> > > > and then set event->fd =3D -response_id.
> > > > We want to skip the range -1..-255 because it is used to report
> > > > fd open errors with FAN_REPORT_FD_ERROR.
> > >
> > > I kind of like this. It looks elegant. The only reason I'm hesitating=
 is
> > > that as you mentioned with persistent notifications we'll likely need
> > > 64-bit type for identifying event. But OTOH requirements there are un=
clear
> > > and I can imagine even userspace assigning the ID. In the worst case =
we
> > > could add info record for this persistent event id.
> >
> > Yes, those persistent id's are inherently different from the response k=
ey,
> > so I am not really worried about duplicity.
> >
> > > So ok, let's do it as you suggest.
> >
> > Cool.
> >
> > I don't think that we even need an explicit FAN_REPORT_EVENT_ID,
> > because it is enough to say that (fid_mode !=3D 0) always means that
> > event->fd cannot be >=3D 0 (like it does today), but with pre-content e=
vents
> > event->fd can be a key < -255?
> >
> > Ibrahim,
> >
> > Feel free to post the patches from my branch, if you want
> > post the event->fd =3D -response_id implementation.
> >
> > I also plan to post them myself when I complete the pre-dir-content pat=
ches.
>
> Sounds good. I will pull in the FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID br=
anch
> and resubmit this patch now that we have consensus on the approach here.

FYI, I pushed some semantic changed to fan_pre_content_fid branch:

- Created shortcut macro FAN_CLASS_PRE_CONTENT_FID
- Created a group priority FSNOTIFY_PRIO_PRE_CONTENT_FID

Regarding the question whether reporting response_id instead of event->fd
requires an opt-in, so far my pre-dir-content patches can report event->fd,
so my preference id the reposonse_id behavior will require opt-in with init
flag FAN_REPORT_RESPONSE_ID.

I suggest to change the uapi as follows:

@@ -67,6 +67,7 @@
 #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target id =
 */
 #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report err=
or */
 #define FAN_REPORT_MNT         0x00004000      /* Report mount events */
+#define FAN_REPORT_RESPONSE_ID 0x00008000      /* event->fd is a response =
id */

 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -144,7 +145,10 @@ struct fanotify_event_metadata {
        __u8 reserved;
        __u16 metadata_len;
        __aligned_u64 mask;
-       __s32 fd;
+       union {
+               __s32 fd;
+               __s32 id; /* FAN_REPORT_RESPONSE_ID */
+       }
        __s32 pid;
 };

@@ -228,7 +232,10 @@ struct fanotify_event_info_mnt {
 #define FAN_RESPONSE_INFO_AUDIT_RULE   1

 struct fanotify_response {
-       __s32 fd;
+       union {
+               __s32 fd;
+               __s32 id; /* FAN_REPORT_RESPONSE_ID */
+       }
        __u32 response;
 };

And to add a check like this:

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1583,6 +1583,16 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int,
flags, unsigned int, event_f_flags)
            (class | fid_mode) !=3D FAN_CLASS_PRE_CONTENT_FID)
                return -EINVAL;

+       /*
+        * With group that reports fid info and allows only pre-content eve=
nts,
+        * user may request to get a response id instead of event->fd.
+        * FAN_REPORT_FD_ERROR does not make sense in this case.
+        */
+       if ((flags & FAN_REPORT_RESPONSE_ID) &&
+           ((flag & FAN_REPORT_FD_ERROR) ||
+            !fid_mode || class !=3D FAN_CLASS_PRE_CONTENT_FID))
+               return -EINVAL;
+


This new group mode is safe, because:
1. event->fd is redundant to target fid
2. other group priorities allow mixing async events in the same group
    async event can have negative event->fd which signifies an error
    to open event->fd

With FAN_CLASS_PRE_CONTENT_FID mode, the value reported in event->id
can ALWAYS be written to response->id, regardless of FAN_REPORT_RESPONSE_ID
because it can never be an error value.

Thanks,
Amir.

