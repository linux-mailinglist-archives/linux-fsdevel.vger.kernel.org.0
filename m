Return-Path: <linux-fsdevel+bounces-58233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C93B2B6D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D395E8A88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC0028750B;
	Tue, 19 Aug 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6T4BGWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471F28727A
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569793; cv=none; b=cCbDQBZ/ErywDLZTAp/lBdxG0GNdwDXcwsUokyzS7pQv1djinVhrLPi/9L1S5g8tmTC9VZLI5tRxMOtthNfUS8BLoj3twOtak9NeA7h1DRyl5Mnrzh6zKP+n7gBqA0qMboRiWjVAVulkixd5AdHSr0XQ4GeCpsZ4V4c3kqk9E1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569793; c=relaxed/simple;
	bh=ucQy/FAW2vyqgJfFpOKDvRaM0/ujATTJ2DXJMNJWyXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJ8fkaiK+hOQuIDu4YN/VZpieue+4W+ihaRii4oq7h/anQD8PxwWMJjjSfiGKhsZ5UetCu4OnCX+7xgWlU7WxtKC8upX4n6cNbp11NTioOxlHXsAT6KwyNVqzWSJax/FBJds5tjHpXrks/Nk+80uDwxtcXo5fJwfoDlvZ8nTXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6T4BGWW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-619ff42ad8eso3271122a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 19:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755569790; x=1756174590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAzHHcs74QRjS2iPgxA7nPymTQThTKoeG61AV0vYLRc=;
        b=f6T4BGWWsKkZLdVQfFF9JfK1aY3siD1lD8UX/xdBLFfEa7gyRqBSxNcYGSD38IRtIs
         VQJ/bauwDRYn8iU20bzs5IE+P4wK6g5n1Tfb7CQNDN3YwIVNsXNq7Qz2THd101Om84br
         AC2VRI5ZWL+bV6DcYkSYCk59oIPEZ111IzWvZxjyDOB9tXhD/29vcUH5yeBb3LGEjEr4
         352WBtni/PCGU94oD9QikWI8mVdupfEY5m/pNNH4FipHhXaDv/CgrtGWUuxbAaj8NWV1
         irnfXcLeyfPHbbJQRvT0nAjKwOQeNr2tP+7Z2KVbCE1YQcXZJgdNuiyFgpn04ESrSpOv
         l7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755569790; x=1756174590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAzHHcs74QRjS2iPgxA7nPymTQThTKoeG61AV0vYLRc=;
        b=mCmPk+NnjFgNZgTU1gMvG0COnFsEYgFw5rLUT8VURDqZU6UeEciiyftZAh2AB3PRTi
         BZAJlT5QlsZtI3xbqKVw1Cj+JAzt7pJL/SnWNFNZNcSF/8o00XphHP0cjgSCA4RJ9hqV
         Q2TWT99BoD9iACDQZSGfLblezUN+AyrtcCHAKox0R9i9xbbT9QzJYA0VObzm+DFbOcjo
         zOdawm592kAYbohkpU02a7gJWOsD9BYUKGo03BP4vt5cRtT/RJhsFk5SOUvNaQindLOd
         4uYLV4SYPcxQ1Fp8qvIxWBu3D8w4WI1ms9W7jDRCsfSpZjXkUGcFpGCOE2Fsx/QwRX2x
         VWAw==
X-Gm-Message-State: AOJu0YxlS8XFMDfkiRghudw2eZ0XJbUC9Pq21/2qSMuyzmKIFme7E0/6
	Sh3i6SQpXFAalxFGAct0SzKwJCT+Yuq8Buimfe2wiDO3PDng4qjV8ps6aRsQuZfWlcMJWZQ3hln
	MIhfEjB3X6PRdEw/GItoIwcD0NPjNFO+KP7irx/s=
X-Gm-Gg: ASbGncu1v34u1wM/EyiG7Tk+351x//Ka9PyzAaj5oAdSANNrgBvy1eafDk6SioyMv8G
	bHwf19DmbOti2mKQoB271EUMtglRYq1HdDMDRftbMZQOSV3Rwtl0dibskej8h4DMLYkQ19o3bbQ
	i/3+Ya7mcJ5sI2dj6WOmwhHL+awnM3ZkiCzkTL0dLBUIQzAYP/Oqw1glPxpx7WT5fJwbHBTf781
	7aHajw=
X-Google-Smtp-Source: AGHT+IF1ZT15GqwZB4SfXmom0RjlBhgtyL4z0yLwKxno6C9mtdYJcj0xcIlHSq4zL5mkw8uPnzpldit4PbHoHf6r+24=
X-Received: by 2002:a05:6402:1ecd:b0:618:6a75:2d76 with SMTP id
 4fb4d7f45d1cf-61a7e4733e0mr643470a12.0.1755569790134; Mon, 18 Aug 2025
 19:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzScM+UFXCuw5F3B3rZ8iFFyZxwSwBHJD6XwPnHVtqr5JMg@mail.gmail.com>
 <E1CDDCDF-0461-4522-985E-07EF212FE927@bsbernd.com> <CAGmFzSe+Qcpmtrav_LUxJtehwXQ3K=5Srd1Y2mvs4Y-k7m05zQ@mail.gmail.com>
 <5f63c8e3-c246-442a-a3a6-d455c0ee9302@bsbernd.com>
In-Reply-To: <5f63c8e3-c246-442a-a3a6-d455c0ee9302@bsbernd.com>
From: Gang He <dchg2000@gmail.com>
Date: Tue, 19 Aug 2025 10:16:17 +0800
X-Gm-Features: Ac12FXxb5ifpSYINq5SAr3ALYCE4jkVuDBKrwEu07s_7d2fuAdaGwoSHnmy4Yic
Message-ID: <CAGmFzSe66awps9Tbnzex3J8Tn18Q6aEVF3uJnwJfVAsn36_yrg@mail.gmail.com>
Subject: Re: Fuse over io_uring mode cannot handle iodepth > 1 case properly
 like the default mode
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

Bernd Schubert <bernd@bsbernd.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 01:31=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 8/18/25 03:39, Gang He wrote:
> > Hi Bernd,
> >
> > Bernd Schubert <bernd@bsbernd.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8816=
=E6=97=A5=E5=91=A8=E5=85=AD 04:56=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On August 15, 2025 9:45:34 AM GMT+02:00, Gang He <dchg2000@gmail.com> =
wrote:
> >>> Hi Bernd,
> >>>
> >>> Sorry for interruption.
> >>> I tested your fuse over io_uring patch set with libfuse null example,
> >>> the fuse over io_uring mode has better performance than the default
> >>> mode. e.g., the fio command is as below,
> >>> fio -direct=3D1 --filename=3D/mnt/singfile --rw=3Dread  -iodepth=3D1
> >>> --ioengine=3Dlibaio --bs=3D4k --size=3D4G --runtime=3D60 --numjobs=3D=
1
> >>> -name=3Dtest_fuse1
> >>>
> >>> But, if I increased fio iodepth option, the fuse over io_uring mode
> >>> has worse performance than the default mode. e.g., the fio command is
> >>> as below,
> >>> fio -direct=3D1 --filename=3D/mnt/singfile --rw=3Dread  -iodepth=3D4
> >>> --ioengine=3Dlibaio --bs=3D4k --size=3D4G --runtime=3D60 --numjobs=3D=
1
> >>> -name=3Dtest_fuse2
> >>>
> >>> The test result showed the fuse over io_uring mode cannot handle this
> >>> case properly. could you take a look at this issue? or this is design
> >>> issue?
> >>>
> >>> I went through the related source code, I do not understand each
> >>> fuse_ring_queue thread has only one  available ring entry? this desig=
n
> >>> will cause the above issue?
> >>> the related code is as follows,
> >>> dev_uring.c
> >>> 1099
> >>> 1100     queue =3D ring->queues[qid];
> >>> 1101     if (!queue) {
> >>> 1102         queue =3D fuse_uring_create_queue(ring, qid);
> >>> 1103         if (!queue)
> >>> 1104             return err;
> >>> 1105     }
> >>> 1106
> >>> 1107     /*
> >>> 1108      * The created queue above does not need to be destructed in
> >>> 1109      * case of entry errors below, will be done at ring destruct=
ion time.
> >>> 1110      */
> >>> 1111
> >>> 1112     ent =3D fuse_uring_create_ring_ent(cmd, queue);
> >>> 1113     if (IS_ERR(ent))
> >>> 1114         return PTR_ERR(ent);
> >>> 1115
> >>> 1116     fuse_uring_do_register(ent, cmd, issue_flags);
> >>> 1117
> >>> 1118     return 0;
> >>> 1119 }
> >>>
> >>>
> >>> Thanks
> >>> Gang
> >>
> >>
> >> Hi Gang,
> >>
> >> we are just slowly traveling back with my family from Germany to Franc=
e - sorry for delayed responses.
> >>
> >> Each queue can have up to N ring entries - I think I put in max 65535.
> >>
> >> The code you are looking at will just add new entries to per queue lis=
ts.
> >>
> >> I don't know why higher fio io-depth results in lower performance. A p=
ossible reason is that /dev/fuse request get distributed to multiple thread=
s, while fuse-io-uring might all go the same thread/ring. I had posted patc=
hes recently that add request  balancing between queues.
> > Io-depth > 1 case means asynchronous IO implementation, but from the
> > code in the fuse_uring_commit_fetch() function, this function
> > completes one IO request, then fetches the next request. This logic
> > will block handling more IO requests before the last request is being
> > processed in this thread. Can each thread accept more IO requests
> > before the last request in the thread is being processed? Maybe this
> > is the root cause for fio (iodepth>1) test case.
>
>
> Well, there is a missing io-uring kernel feature - io_uring_cmd_done()
> can only complete one SQE at a time. There is no way right now
> to to batch multiple "struct io_uring_cmd". Although I personally
> doubt that this is the limit you are running into.
OK, I got this design background, but I want to know if we can handle
the next fuse request immediately after the
io_uring_cmd_done() function is called in the kernel space, rather
than in the fuse_uring_commit_fetch() function.
I do not know my suggestion makes sense in the io_uring mechanism, but
from the coding view, we should handle
the next fuse request as soon as possible.
Second, if we cannot change this design, we should send the fuse
request to another thread queue when the current thread queue is
handling the fuse request, but maybe this change will bring
performance drop in the numa case for the single thread fio testing.

Thanks
Gang

