Return-Path: <linux-fsdevel+bounces-31368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCD39958DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FFC2826FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C302139C7;
	Tue,  8 Oct 2024 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk/OnXCd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538758222
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421138; cv=none; b=miD9sI2VXcfYQOaCW86aXUycLrR1FZfBGIkVKYyH7hvMSUEdFAKGourZfo4+pPYPOtqhDStn81L59IOakIVb8cgS2lgAQIGiTWSxqYWn9jgajJ3Gy4YzJvfTi7ZuJUOOHEnheOrqscLpztgj8gv06jjwcMP7nNwocR3t0DojoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421138; c=relaxed/simple;
	bh=CaFISocR5q22jjc4bwc4u++HUdN//lzZXGoypl13Voc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTa3tSsBrUyo0uitjUgCCgTgS/uTohxqVq9YuiF54GbLYXr4wRKW82TaaVfoqbClFXXap09xAs3gTTNYyy5AZVgxzgr30C6Ljz1zuPnCVdKUPmMGC/PUT7JidEx0zMiPMjLdoM1pLdrqp7AI6pUbNqdq5ff4z0Jbqwmj/7yLYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mk/OnXCd; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4581ee65b46so54629281cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728421136; x=1729025936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obUevo8wCC2YiTiDXbKHj5O8azRthJyM4gWFX0itc3A=;
        b=mk/OnXCdCZrsBIyKkg6r/HajrVc5HYoRK9ThDSbSfi/R+J3WQd+CDMlIZLYo4z9LHV
         zPP8TusNTX+E+xi9C/dLzPFAJZH/Ia6db6VakKyI/iUI9Q1xwPi0NE5lhrenJyw4GO/t
         Sea0BqI6jum4ObyafU1AXJp25kgHITfBBbrCmVsiM4XPXPbO5HTtCUhotHIfE+j/oF6o
         sCVuANjbBjlnXLxyZ3v0iUSMU0fb5bXSi94aitvZ3B650IR5fYoAhRXvsFqLp6hvAhin
         SbDkdOr+FcRdEis4adQkOACa1y/Wa3uoalI0XG7Ype5lrI4KlN4D7SnV8eNKrTgW14x4
         4nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728421136; x=1729025936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obUevo8wCC2YiTiDXbKHj5O8azRthJyM4gWFX0itc3A=;
        b=Hb34Er4m6g4poKwlG6hDAUMlCbGFVtM7fmxP9YbvxlTfW6uSmoeP5ci+TcKa6OcRen
         qCNb3WjbF3SQ6ozbHj7dzjGsYlKYQ8ZACWCaXUG4CwoaUsTxQv0vI173et29L+wW5Ggq
         qCOxBQhcspheODRZKexyccQLkf7Uj8vL2C7WI7Fjw0aQRtID4yd444OfvlDIEub54I4m
         p5ZGS5IpvrNydFuIRi+DkBcuh6xVQo90NZ4mX+rkPNEhMmSKfrmceaIc4n7RCQp4mtaJ
         xXWuVjzQORua9XK3+43FlsAFjszXxtyLQjmc32eQTTS0uAcDTlfM89LJBkXHSfhW1RCv
         rEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL8rYdCuFVVMkKZ+9+l7Y/t98DkoWzsiith2Jlci3hK/MsDslqJ/sCmZ5r/psfVWg0VUAYPZfZdXe8DtrM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2sqjbE52lYMXW6v56OGaKrGvFE+ewMgYC6HysX/YXTQ+0rVs
	oqnGnLeschVZPFMA0PrNPfYZWvKbr8LeET+dFx2hcD4phdoJUHjl3Wgqj07ot/A+MzeJUEaE6Dp
	tT9WQrmSusr8pmUrghzTrHM9DMBc=
X-Google-Smtp-Source: AGHT+IGFQdK9Mb0mWBgj+vrCkG2JADTlQSwQ+O5WoonPmXABTlQ0DBUW47oLmBJSzCo4Qbfyod1XbfMoly8QEg4k2mk=
X-Received: by 2002:a05:622a:199f:b0:458:2fb7:5035 with SMTP id
 d75a77b69052e-45fa5ecc35amr2876131cf.3.1728421135632; Tue, 08 Oct 2024
 13:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007184258.2837492-1-joannelkoong@gmail.com>
In-Reply-To: <20241007184258.2837492-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Oct 2024 13:58:44 -0700
Message-ID: <CAJnrk1b30f3O2pJ+gxsDqCL-gQ8EkXz9AvFfMKkyR0xd-SD-bg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] fuse: add kernel-enforced request timeout option
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:43=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is in a deadlock. Currently, there's
> no good way to detect if a server is stuck and needs to be killed
> manually.
>
> This patchset adds a timeout option where if the server does not reply to=
 a
> request by the time the timeout elapses, the connection will be aborted.
> This patchset also adds two dynamically configurable fuse sysctls
> "default_request_timeout" and "max_request_timeout" for controlling/enfor=
cing
> timeout behavior system-wide.
>
> Existing systems running fuse servers will not be affected unless they
> explicitly opt into the timeout.
>
> v6:
> https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelkoo=
ng@gmail.com/
> Changes from v6 -> v7:
> - Make timer per-connection instead of per-request (Miklos)
> - Make default granularity of time minutes instead of seconds
> - Removed the reviewed-bys since the interface of this has changed (now
>   minutes, instead of seconds)
>
> v5:
> https://lore.kernel.org/linux-fsdevel/20240826203234.4079338-1-joannelkoo=
ng@gmail.com/
> Changes from v5 -> v6:
> - Gate sysctl.o behind CONFIG_SYSCTL in makefile (kernel test robot)
> - Reword/clarify last sentence in cover letter (Miklos)
>
> v4:
> https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoo=
ng@gmail.com/
> Changes from v4 -> v5:
> - Change timeout behavior from aborting request to aborting connection
>   (Miklos)
> - Clarify wording for sysctl documentation (Jingbo)
>
> v3:
> https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoo=
ng@gmail.com/
> Changes from v3 -> v4:
> - Fix wording on some comments to make it more clear
> - Use simpler logic for timer (eg remove extra if checks, use mod timer A=
PI)
>   (Josef)
> - Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
> - Fix comment for "processing queue", add req->fpq =3D NULL safeguard  (B=
ernd)
>
> v2:
> https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoo=
ng@gmail.com/
> Changes from v2 -> v3:
> - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
> - Disarm timer in error handling for fatal interrupt (Yafang)
> - Clean up do_fuse_request_end (Jingbo)
> - Add timer for notify retrieve requests
> - Fix kernel test robot errors for #define no-op functions
>
> v1:
> https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoo=
ng@gmail.com/
> Changes from v1 -> v2:
> - Add timeout for background requests
> - Handle resend race condition
> - Add sysctls
>
> Joanne Koong (3):
>   fs_parser: add fsparam_u16 helper
>   fuse: add optional kernel-enforced timeout for requests
>   fuse: add default_request_timeout and max_request_timeout sysctls
>
>  Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++++
>  fs/fs_parser.c                          | 14 ++++++
>  fs/fuse/dev.c                           | 63 ++++++++++++++++++++++++-
>  fs/fuse/fuse_i.h                        | 55 +++++++++++++++++++++
>  fs/fuse/inode.c                         | 34 +++++++++++++
>  fs/fuse/sysctl.c                        | 20 ++++++++
>  include/linux/fs_parser.h               |  9 ++--
>  7 files changed, 218 insertions(+), 4 deletions(-)
>
> --
> 2.43.5
>

These are the benchmark numbers I am seeing on my machine:

--- Machine info ---
Architecture:             x86_64
CPU(s):                   36
  On-line CPU(s) list:    0-35
Model name:             Intel(R) Xeon(R) D-2191A CPU @ 1.60GHz
    BIOS Model name:      Intel(R) Xeon(R) D-2191A CPU @ 1.60GHz
    CPU family:           6
    Model:                85
    Thread(s) per core:   2
    Core(s) per socket:   18
    Socket(s):            1
    Stepping:             4
    Frequency boost:      disabled
    CPU(s) scaling MHz:   100%
    CPU max MHz:          1601.0000
    CPU min MHz:          800.0000


--- Setting up the testing environment ---

sudo mount -t tmpfs -o size=3D10G tmpfs ~/tmp_mount

Mount libfuse server for tests:
for test a) Non-passthrough writes -
./libfuse/build/example/passthrough_ll -o max_threads=3D4  -o
source=3D/root/tmp_mount /root/fuse_mount
for test b) Passthrough writes -
./libfuse/build/example/passthrough_hp --num-threads=3D4
/root/tmp_mount.  /root/fuse_mount

Test using fio:
fio --name=3Dseqwrite --ioengine=3Dsync --rw=3Dwrite --bs=3D1k --size=3D1G
--numjobs=3D4 --fallocate=3Dnone --ramp_time=3D30 --group_reporting=3D1
--directory=3D/root/fuse_mount

Enable timeouts by running 'echo 500  | sudo tee
/proc/sys/fs/fuse/default_request_timeout' before mounting fuse server
Disable timeouts by running 'echo 0  | sudo tee
/proc/sys/fs/fuse/default_request_timeout' before mounting fuse server

Discarded outliers


--- Tests ---
a) Non-passthrough sequential writes
 ./libfuse/build/example/passthrough_ll -o max_threads=3D4  -o
source=3D/root/tmp_mount /root/fuse_mount

--- Baseline (no timeouts) ---
Ran this on origin/for-next
Saw around ~273 MiB/s
WRITE: bw=3D277MiB/s (291MB/s), 277MiB/s-277MiB/s (291MB/s-291MB/s),
io=3D4096MiB (4295MB), run=3D14761-14761msec
WRITE: bw=3D271MiB/s (285MB/s), 271MiB/s-271MiB/s (285MB/s-285MB/s),
io=3D4096MiB (4295MB), run=3D15091-15091msec
WRITE: bw=3D274MiB/s (287MB/s), 274MiB/s-274MiB/s (287MB/s-287MB/s),
io=3D4096MiB (4295MB), run=3D14949-14949msec
WRITE: bw=3D277MiB/s (290MB/s), 277MiB/s-277MiB/s (290MB/s-290MB/s),
io=3D4096MiB (4295MB), run=3D14801-14801msec
WRITE: bw=3D274MiB/s (288MB/s), 274MiB/s-274MiB/s (288MB/s-288MB/s),
io=3D4096MiB (4295MB), run=3D14939-14939msec
WRITE: bw=3D272MiB/s (285MB/s), 272MiB/s-272MiB/s (285MB/s-285MB/s),
io=3D4096MiB (4295MB), run=3D15060-15060msec
WRITE: bw=3D269MiB/s (282MB/s), 269MiB/s-269MiB/s (282MB/s-282MB/s),
io=3D4096MiB (4295MB), run=3D15254-15254msec
WRITE: bw=3D272MiB/s (285MB/s), 272MiB/s-272MiB/s (285MB/s-285MB/s),
io=3D4096MiB (4295MB), run=3D15055-15055msec
WRITE: bw=3D275MiB/s (288MB/s), 275MiB/s-275MiB/s (288MB/s-288MB/s),
io=3D4096MiB (4295MB), run=3D14893-14893msec
WRITE: bw=3D270MiB/s (283MB/s), 270MiB/s-270MiB/s (283MB/s-283MB/s),
io=3D4096MiB (4295MB), run=3D15176-15176msec

--- Request timeouts with periodic timer (approach from this patchset) ---
Saw around ~271MiB/s
WRITE: bw=3D265MiB/s (278MB/s), 265MiB/s-265MiB/s (278MB/s-278MB/s),
io=3D4096MiB (4295MB), run=3D15454-15454msec
WRITE: bw=3D268MiB/s (281MB/s), 268MiB/s-268MiB/s (281MB/s-281MB/s),
io=3D4096MiB (4295MB), run=3D15262-15262msec
WRITE: bw=3D271MiB/s (284MB/s), 271MiB/s-271MiB/s (284MB/s-284MB/s),
io=3D4096MiB (4295MB), run=3D15113-15113msec
WRITE: bw=3D268MiB/s (281MB/s), 268MiB/s-268MiB/s (281MB/s-281MB/s),
io=3D4096MiB (4295MB), run=3D15301-15301msec
WRITE: bw=3D274MiB/s (287MB/s), 274MiB/s-274MiB/s (287MB/s-287MB/s),
io=3D4096MiB (4295MB), run=3D14965-14965msec
WRITE: bw=3D268MiB/s (281MB/s), 268MiB/s-268MiB/s (281MB/s-281MB/s),
io=3D4096MiB (4295MB), run=3D15277-15277msec
WRITE: bw=3D276MiB/s (290MB/s), 276MiB/s-276MiB/s (290MB/s-290MB/s),
io=3D4096MiB (4295MB), run=3D14828-14828msec
WRITE: bw=3D272MiB/s (285MB/s), 272MiB/s-272MiB/s (285MB/s-285MB/s),
io=3D4096MiB (4295MB), run=3D15069-15069msec
WRITE: bw=3D273MiB/s (287MB/s), 273MiB/s-273MiB/s (287MB/s-287MB/s),
io=3D4096MiB (4295MB), run=3D14987-14987msec
WRITE: bw=3D279MiB/s (293MB/s), 279MiB/s-279MiB/s (293MB/s-293MB/s),
io=3D4096MiB (4295MB), run=3D14662-14662msec
WRITE: bw=3D272MiB/s (285MB/s), 272MiB/s-272MiB/s (285MB/s-285MB/s),
io=3D4096MiB (4295MB), run=3D15071-15071msec

--- Request timeouts with one timer per request (approach from v6 [1]) ---
Saw around ~263MiB/s
WRITE: bw=3D262MiB/s (275MB/s), 262MiB/s-262MiB/s (275MB/s-275MB/s),
io=3D4096MiB (4295MB), run=3D15620-15620msec
WRITE: bw=3D262MiB/s (275MB/s), 262MiB/s-262MiB/s (275MB/s-275MB/s),
io=3D4096MiB (4295MB), run=3D15614-15614msec
WRITE: bw=3D256MiB/s (269MB/s), 256MiB/s-256MiB/s (269MB/s-269MB/s),
io=3D4096MiB (4295MB), run=3D15995-15995msec
WRITE: bw=3D264MiB/s (277MB/s), 264MiB/s-264MiB/s (277MB/s-277MB/s),
io=3D4096MiB (4295MB), run=3D15504-15504msec
WRITE: bw=3D260MiB/s (273MB/s), 260MiB/s-260MiB/s (273MB/s-273MB/s),
io=3D4096MiB (4295MB), run=3D15749-15749msec
WRITE: bw=3D267MiB/s (280MB/s), 267MiB/s-267MiB/s (280MB/s-280MB/s),
io=3D4096MiB (4295MB), run=3D15354-15354msec
WRITE: bw=3D266MiB/s (279MB/s), 266MiB/s-266MiB/s (279MB/s-279MB/s),
io=3D4096MiB (4295MB), run=3D15409-15409msec
WRITE: bw=3D265MiB/s (277MB/s), 265MiB/s-265MiB/s (277MB/s-277MB/s),
io=3D4096MiB (4295MB), run=3D15480-15480msec
WRITE: bw=3D268MiB/s (281MB/s), 268MiB/s-268MiB/s (281MB/s-281MB/s),
io=3D4096MiB (4295MB), run=3D15283-15283msec
WRITE: bw=3D267MiB/s (280MB/s), 267MiB/s-267MiB/s (280MB/s-280MB/s),
io=3D4096MiB (4295MB), run=3D15332-15332msec


b) Passthrough sequential writes
./libfuse/build/example/passthrough_hp --num-threads=3D4
/root/tmp_mount.  /root/fuse_mount

--- Baseline (no timeouts) ---
Ran this on origin/for-next
Saw around ~245 MiB/s
WRITE: bw=3D246MiB/s (258MB/s), 246MiB/s-246MiB/s (258MB/s-258MB/s),
io=3D4096MiB (4295MB), run=3D16676-16676msec
WRITE: bw=3D248MiB/s (260MB/s), 248MiB/s-248MiB/s (260MB/s-260MB/s),
io=3D4096MiB (4295MB), run=3D16508-16508msec
WRITE: bw=3D246MiB/s (258MB/s), 246MiB/s-246MiB/s (258MB/s-258MB/s),
io=3D4096MiB (4295MB), run=3D16636-16636msec
WRITE: bw=3D246MiB/s (258MB/s), 246MiB/s-246MiB/s (258MB/s-258MB/s),
io=3D4096MiB (4295MB), run=3D16654-16654msec
WRITE: bw=3D242MiB/s (253MB/s), 242MiB/s-242MiB/s (253MB/s-253MB/s),
io=3D4096MiB (4295MB), run=3D16957-16957msec
WRITE: bw=3D249MiB/s (261MB/s), 249MiB/s-249MiB/s (261MB/s-261MB/s),
io=3D4096MiB (4295MB), run=3D16449-16449msec
WRITE: bw=3D245MiB/s (257MB/s), 245MiB/s-245MiB/s (257MB/s-257MB/s),
io=3D4096MiB (4295MB), run=3D16699-16699msc
WRITE: bw=3D241MiB/s (253MB/s), 241MiB/s-241MiB/s (253MB/s-253MB/s),
io=3D4096MiB (4295MB), run=3D16981-16981msec
WRITE: bw=3D244MiB/s (256MB/s), 244MiB/s-244MiB/s (256MB/s-256MB/s),
io=3D4096MiB (4295MB), run=3D16792-16792msec
WRITE: bw=3D246MiB/s (258MB/s), 246MiB/s-246MiB/s (258MB/s-258MB/s),
io=3D4096MiB (4295MB), run=3D16665-16665msec

--- Request timeouts with periodic timer (approach from this patchset) ---
Saw around ~237 MiB/s
WRITE: bw=3D237MiB/s (248MB/s), 237MiB/s-237MiB/s (248MB/s-248MB/s),
io=3D4096MiB (4295MB), run=3D17295-17295msec
WRITE: bw=3D236MiB/s (247MB/s), 236MiB/s-236MiB/s (247MB/s-247MB/s),
io=3D4096MiB (4295MB), run=3D17357-17357msec
WRITE: bw=3D240MiB/s (251MB/s), 240MiB/s-240MiB/s (251MB/s-251MB/s),
io=3D4096MiB (4295MB), run=3D17096-17096msec
WRITE: bw=3D238MiB/s (249MB/s), 238MiB/s-238MiB/s (249MB/s-249MB/s),
io=3D4096MiB (4295MB), run=3D17245-17245msec
WRITE: bw=3D236MiB/s (247MB/s), 236MiB/s-236MiB/s (247MB/s-247MB/s),
io=3D4096MiB (4295MB), run=3D17365-17365msec
WRITE: bw=3D235MiB/s (246MB/s), 235MiB/s-235MiB/s (246MB/s-246MB/s),
io=3D4096MiB (4295MB), run=3D17466-17466msec
WRITE: bw=3D235MiB/s (246MB/s), 235MiB/s-235MiB/s (246MB/s-246MB/s),
io=3D4096MiB (4295MB), run=3D17444-17444msec
WRITE: bw=3D241MiB/s (253MB/s), 241MiB/s-241MiB/s (253MB/s-253MB/s),
io=3D4096MiB (4295MB), run=3D17003-17003msec
WRITE: bw=3D236MiB/s (247MB/s), 236MiB/s-236MiB/s (247MB/s-247MB/s),
io=3D4096MiB (4295MB), run=3D17361-17361msec
WRITE: bw=3D244MiB/s (256MB/s), 244MiB/s-244MiB/s (256MB/s-256MB/s),
io=3D4096MiB (4295MB), run=3D16777-16777msec

--- Request timeouts with one timer per request (approach from v6 [1]) ---
Saw around ~232 MiB/s
WRITE: bw=3D230MiB/s (241MB/s), 230MiB/s-230MiB/s (241MB/s-241MB/s),
io=3D4096MiB (4295MB), run=3D17816-17816msec
WRITE: bw=3D233MiB/s (244MB/s), 233MiB/s-233MiB/s (244MB/s-244MB/s),
io=3D4096MiB (4295MB), run=3D17613-17613msec
WRITE: bw=3D231MiB/s (242MB/s), 231MiB/s-231MiB/s (242MB/s-242MB/s),
io=3D4096MiB (4295MB), run=3D17716-17716msec
WRITE: bw=3D231MiB/s (242MB/s), 231MiB/s-231MiB/s (242MB/s-242MB/s),
io=3D4096MiB (4295MB), run=3D17728-17728msec
WRITE: bw=3D233MiB/s (244MB/s), 233MiB/s-233MiB/s (244MB/s-244MB/s),
io=3D4096MiB (4295MB), run=3D17578-17578msec
WRITE: bw=3D232MiB/s (243MB/s), 232MiB/s-232MiB/s (243MB/s-243MB/s),
io=3D4096MiB (4295MB), run=3D17676-17676msec
WRITE: bw=3D231MiB/s (242MB/s), 231MiB/s-231MiB/s (242MB/s-242MB/s),
io=3D4096MiB (4295MB), run=3D17761-17761msec
WRITE: bw=3D234MiB/s (245MB/s), 234MiB/s-234MiB/s (245MB/s-245MB/s),
io=3D4096MiB (4295MB), run=3D17529-17529msec
WRITE: bw=3D230MiB/s (241MB/s), 230MiB/s-230MiB/s (241MB/s-241MB/s),
io=3D4096MiB (4295MB), run=3D17823-17823msec
WRITE: bw=3D235MiB/s (247MB/s), 235MiB/s-235MiB/s (247MB/s-247MB/s),
io=3D4096MiB (4295MB), run=3D17393-17393msec


Overall
-  request timeouts with a periodic timer performs better than the
approach in v6 of attaching one timer to each request.
- I didn't see a significant difference in performance with enabling
timers when running non-passthrough fuse server, but did see about a
3% drop on passthrough servers


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelk=
oong@gmail.com/

