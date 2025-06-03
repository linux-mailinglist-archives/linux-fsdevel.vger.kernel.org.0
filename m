Return-Path: <linux-fsdevel+bounces-50416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB99ACBFF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 07:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5353A6118
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 05:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98AB1FBCB0;
	Tue,  3 Jun 2025 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eraGGQj9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2619125B9;
	Tue,  3 Jun 2025 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748930082; cv=none; b=ieomd9MCBvO9m+v6UagyCzFgYPJUwW1NYaFT4eiAFkX5AW0tNdGvDxnTeVlNSJV65kkmweVJwoLFoNjY+zMuYqPi+ar1vTjTPMdRBUWlABsFJeXAicixGGvS0aNDlcE52sWK6s7ySgyCMIFumkYRuHYZg9iWM1XptsY4BT0xVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748930082; c=relaxed/simple;
	bh=mh5hC8NR4I5UtbU6afhpXtkFyXMP7WzIjIfb+Zrkb0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGWYgEF27iaitCD8U317noQHREqz2eQ6/SI7WULcltVxzB2/eOpVJCecbdqp1xW4JHlv+uPEkg9xgrCOhA/s5gdM5yklxQ7A5cew72Vy7awXnyMYMAD5jIcw5fmAjXKSjKPR7XfVcxZhWuFyNiQwaXMmsB7FSxwkG8BkfZwk/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eraGGQj9; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d09d45366dso482857185a.2;
        Mon, 02 Jun 2025 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748930078; x=1749534878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWj8RwJXi57KCIgTSqIWtQ1pNoTucbBICqmEsyLL3TI=;
        b=eraGGQj9aoigkStnUYCbh7bfPhiOhE846VSwhWU0Z/55L1uESy9CNfGyBCfSWTfc0v
         CxCTOCiWUJhSJ9WTdOqv1ax51CpOvwRd1EnQ6Mc7XxjX4Z9AsM7L3ygS8BIWgq6OUMJU
         L9kftG5x41m+lFOpPW5C9VEWiGLT4uMWUpKftz1m7JLc+enIwPlX93aXkmmuT4xeu6d7
         TA0NHbXbuSsIB3OWN4ibig2bJ4l9qVkqUmChRmd0E/OiTZq7FQxcDW+PCfYDZ32d0U3q
         nWJpJhzFMhsFO0nwOTZ4sRxrZyubbIrbEyv2xr8xbLi+Ez/4sBRQvQsbBNBxYq/GaSQh
         xutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748930078; x=1749534878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWj8RwJXi57KCIgTSqIWtQ1pNoTucbBICqmEsyLL3TI=;
        b=EeoEdU8koU2OIGB+yDOjI4fzu2k9/WXGGp6Dq4znXPctzqbRi4fwxMZ/azEwdyEkqo
         9ECSiP/Emb0D8URfIf1MD/M2c3l2g6sOSmzzXvsZIfzzJiNQqpjzdIgOWagQJ3cbHCKl
         HQFV6QI7TVxZKNMsZU+PWd/Y0A48SW+38+zj43dAwvNs/bfSS//6mBXP4RLdjcN0S1Nn
         VWjZ/k5SX2QBPeJwHP6I14yXE5r1lLNHRCob9t4w4XOTzn4WfYMQV3Me416vvOH5ZZFP
         DbfvgZdsZcAl41YqoWN486UkXmCm48+ijDeTKbKDXz9X5WNTtrgp9l4dZ0OJVpTR9AmY
         CpGA==
X-Forwarded-Encrypted: i=1; AJvYcCU/9Fbo5GYr9BFS5S9i4qMmwP5OTilZ4eo24wwEpTF6ACeNcyTvHrjQyH8g4CyuQTQVMnO7C8B7a0DN@vger.kernel.org, AJvYcCWRC1jz7QCfB45xGOMOspv9lmVyE8PqF7I3LBrzdDSIt4ySLkxY6iJEFs1TrGFHG+4mfcOOoZF8JLFllpZW@vger.kernel.org
X-Gm-Message-State: AOJu0YzcbI+9L+cNjDZVuzzAEhagkEiCreTzFixa8VoR4/2AXYmIRZWn
	bkyl0i/wwaZktb5433sOIIaktw1rn6jccU7059hpenh3ZDhdeuVLs8d7nT9E9qGLdxgratthy8o
	ppQZ4jP+y5cSokKuPQEXexJK/WHWoR0SIW3dms0ND/w==
X-Gm-Gg: ASbGncs3patcmT+6UKfSPJPZN4jCakjyt4PWrpW0b8A8rDC+Q1kqfW9cDueGt/eb16s
	YY2vscIf7gUhAoX9LhdALdKVbkESxO/KdWsOxp7S2UJQ7eTagDOPg5cluIBSjIGqU7UVuwdgds9
	QYDCluMwHQjJ9C9zem8FZZP1V8L0c0tzcBVQ==
X-Google-Smtp-Source: AGHT+IE+uponNmxDdU0K6JcPKNjUhwh39x3Oj9IzRbUXOrUm07l4/M1v+1VGETR7d+xAePYy9wVeN6RUmYEZEtYTB2c=
X-Received: by 2002:a05:620a:261d:b0:7c5:99a6:a1ae with SMTP id
 af79cd13be357-7d0a490398fmr2038297285a.0.1748930078381; Mon, 02 Jun 2025
 22:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aD03HeZWLJihqikU@infradead.org> <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
 <aD5obj2G58bRMFlB@casper.infradead.org> <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>
 <aD5ratf3NF_DUnL-@casper.infradead.org> <CALOAHbB_p=rxT2-7bWudKLUgbD7AvNoBsge90VDgQFpakfTbCQ@mail.gmail.com>
 <aD58p4OpY0QhKl3i@infradead.org> <e2b4db3d-a282-4c96-b333-8d4698e5a705@kernel.org>
In-Reply-To: <e2b4db3d-a282-4c96-b333-8d4698e5a705@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Jun 2025 13:54:02 +0800
X-Gm-Features: AX0GCFuf29oXt11-cRAy-3Y4J5qBSkPEVuQpZ60-ssNTnVsZFYiu6JX7qC7DLK4
Message-ID: <CALOAHbA_ttJmOejYJ+rrRdzKav_BPtwxuKwCSAf2dwLZJ1UyZQ@mail.gmail.com>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org, cem@kernel.org, 
	linux-xfs@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 1:17=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 2025/06/03 13:40, Christoph Hellwig wrote:
> > On Tue, Jun 03, 2025 at 11:50:58AM +0800, Yafang Shao wrote:
> >>
> >> The drive in question is a Western Digital HGST Ultrastar
> >> HUH721212ALE600 12TB HDD.
> >> The price information is unavailable to me;-)
> >
> > Unless you are doing something funky like setting a crazy CDL policy
> > it should not randomly fail writes.  Can you post the dmesg including
> > the sense data that the SCSI code should print in this case?

Below is an error occurred today,

[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] scsi_io_completion_action: 25 callbacks suppress=
ed
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1669 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1669 CDB: Read(16)
88 00 00 00 00 02 0c dc bc c0 00 00 00 58 00 00
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] blk_print_req_error: 25 callbacks suppressed
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] I/O error, dev sdd, sector 8805727424 op
0x0:(READ) flags 0x80700 phys_seg 11 prio class 2
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1693 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1709 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1693 CDB: Read(16)
88 00 00 00 00 01 02 1e 48 50 00 00 00 08 00 00
[Tue Jun  3 10:02:44 2025] I/O error, dev sdd, sector 4330506320 op
0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1709 CDB: Read(16)
88 00 00 00 00 01 80 01 8c 78 00 00 00 08 00 00
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1704 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:44 2025] I/O error, dev sdd, sector 6442552440 op
0x0:(READ) flags 0x81700 phys_seg 1 prio class 2
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1704 CDB: Read(16)
88 00 00 00 00 04 80 18 43 f8 00 00 00 80 00 00
[Tue Jun  3 10:02:44 2025] I/O error, dev sdd, sector 19328943096 op
0x0:(READ) flags 0x80700 phys_seg 16 prio class 2
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1705 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1705 CDB: Read(16)
88 00 00 00 00 04 80 18 85 c8 00 00 03 80 00 00
[Tue Jun  3 10:02:44 2025] I/O error, dev sdd, sector 19328959944 op
0x0:(READ) flags 0x80700 phys_seg 112 prio class 2
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1712 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1712 CDB: Read(16)
88 00 00 00 00 01 cd 06 86 d8 00 00 03 30 00 00
[Tue Jun  3 10:02:44 2025] I/O error, dev sdd, sector 7734724312 op
0x0:(READ) flags 0x80700 phys_seg 102 prio class 2
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1720 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1720 CDB: Read(16)
88 00 00 00 00 02 49 ed 20 c0 00 00 01 60 00 00
[Tue Jun  3 10:02:44 2025] I/O error, dev sdd, sector 9830211776 op
0x0:(READ) flags 0x80700 phys_seg 44 prio class 2
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1707 FAILED Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1707 Sense Key :
Medium Error [current] [descriptor]
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1707 Add. Sense:
Unrecovered read error
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1707 CDB: Read(16)
88 00 00 00 00 05 6b 21 0b e8 00 00 00 08 00 00
[Tue Jun  3 10:02:44 2025] critical medium error, dev sdd, sector
23272164328 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1688 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:44 2025] sd 14:0:4:0: [sdd] tag#1688 CDB: Read(16)
88 00 00 00 00 01 02 0a a6 b8 00 00 00 28 00 00
[Tue Jun  3 10:02:45 2025] I/O error, dev sdd, sector 4329219768 op
0x0:(READ) flags 0x80700 phys_seg 5 prio class 2
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] sd 14:0:4:0: [sdd] tag#1669 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:02:47 2025] sd 14:0:4:0: [sdd] tag#1669 CDB: Read(16)
88 00 00 00 00 01 80 01 7b b0 00 00 00 08 00 00
[Tue Jun  3 10:02:47 2025] I/O error, dev sdd, sector 6442548144 op
0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:47 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:02:49 2025] sdd: writeback error on inode 10741741427,
offset 54525952, sector 11086521712
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] scsi_io_completion_action: 16 callbacks suppress=
ed
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1761 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D3s
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1761 CDB: Read(16)
88 00 00 00 00 02 49 ed 1b 80 00 00 00 88 00 00
[Tue Jun  3 10:03:27 2025] blk_print_req_error: 16 callbacks suppressed
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 9830210432 op
0x0:(READ) flags 0x80700 phys_seg 17 prio class 2
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1880 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D3s
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1880 CDB: Read(16)
88 00 00 00 00 05 50 79 b5 58 00 00 04 00 00 00
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 22824990040 op
0x0:(READ) flags 0x84700 phys_seg 128 prio class 2
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1891 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D3s
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1891 CDB: Read(16)
88 00 00 00 00 02 49 ed cb 08 00 00 01 58 00 00
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 9830255368 op
0x0:(READ) flags 0x80700 phys_seg 43 prio class 2
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1894 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D3s
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1894 CDB: Read(16)
88 00 00 00 00 05 6b 21 19 98 00 00 03 f8 00 00
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 23272167832 op
0x0:(READ) flags 0x80700 phys_seg 127 prio class 2
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1886 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D3s
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1886 CDB: Read(16)
88 00 00 00 00 02 49 ed 1c 08 00 00 00 d8 00 00
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 9830210568 op
0x0:(READ) flags 0x80700 phys_seg 27 prio class 2
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1740 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D3s
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1740 CDB: Read(16)
88 00 00 00 00 03 39 3a 96 90 00 00 04 00 00 00
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 13845042832 op
0x0:(READ) flags 0x80700 phys_seg 128 prio class 2
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1741 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D3s
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1741 CDB: Read(16)
88 00 00 00 00 03 39 3a 9a 90 00 00 04 08 00 00
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 13845043856 op
0x0:(READ) flags 0x84700 phys_seg 128 prio class 2
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1873 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D0s
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1873 CDB: Read(16)
88 00 00 00 00 03 39 3a 9e 98 00 00 04 00 00 00
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 13845044888 op
0x0:(READ) flags 0x80700 phys_seg 128 prio class 2
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1875 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D0s
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1875 CDB: Read(16)
88 00 00 00 00 03 39 3a a2 98 00 00 04 00 00 00
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 13845045912 op
0x0:(READ) flags 0x84700 phys_seg 128 prio class 2
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1856 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D3s
[Tue Jun  3 10:03:27 2025] sd 14:0:4:0: [sdd] tag#1856 CDB: Read(16)
88 00 00 00 00 03 39 3a 92 88 00 00 04 08 00 00
[Tue Jun  3 10:03:27 2025] I/O error, dev sdd, sector 13845041800 op
0x0:(READ) flags 0x84700 phys_seg 128 prio class 2
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:27 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:31 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] scsi_io_completion_action: 48 callbacks suppress=
ed
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1773 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1773 CDB: Read(16)
88 00 00 00 00 01 b4 78 c3 c8 00 00 02 40 00 00
[Tue Jun  3 10:03:35 2025] blk_print_req_error: 48 callbacks suppressed
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 7322780616 op
0x0:(READ) flags 0x80700 phys_seg 72 prio class 2
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1734 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1734 CDB: Read(16)
88 00 00 00 00 02 49 ee 2f 58 00 00 00 88 00 00
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 9830281048 op
0x0:(READ) flags 0x80700 phys_seg 17 prio class 2
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1867 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1867 CDB: Read(16)
88 00 00 00 00 02 49 ee 2f e0 00 00 00 d8 00 00
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 9830281184 op
0x0:(READ) flags 0x80700 phys_seg 15 prio class 2
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1768 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D1s
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1768 CDB: Read(16)
88 00 00 00 00 02 49 ec a6 a0 00 00 00 88 00 00
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1769 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D1s
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 9830180512 op
0x0:(READ) flags 0x80700 phys_seg 3 prio class 2
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1769 CDB: Read(16)
88 00 00 00 00 02 49 ec a7 28 00 00 00 c0 00 00
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1934 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D0s
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 9830180648 op
0x0:(READ) flags 0x80700 phys_seg 24 prio class 2
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1934 CDB: Read(16)
88 00 00 00 00 00 0a d5 b7 20 00 00 03 f8 00 00
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 181778208 op
0x0:(READ) flags 0x80700 phys_seg 127 prio class 2
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1894 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D0s
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1913 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1907 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1757 FAILED Result:
hostbyte=3DDID_SOFT_ERROR driverbyte=3DDRIVER_OK cmd_age=3D2s
[Tue Jun  3 10:03:35 2025] mpt3sas_cm0: log_info(0x31080000):
originator(PL), code(0x08), sub_code(0x0000)
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1907 CDB: Read(16)
88 00 00 00 00 02 49 ec 6c 40 00 00 00 f0 00 00
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1757 CDB: Read(16)
88 00 00 00 00 03 e8 cc 56 a0 00 00 02 d8 00 00
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1913 CDB: Read(16)
88 00 00 00 00 03 e8 cc 56 38 00 00 00 68 00 00
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 9830165432 op
0x0:(READ) flags 0x80700 phys_seg 17 prio class 2
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 21656330648 op
0x0:(READ) flags 0x84700 phys_seg 128 prio class 2
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 16790607520 op
0x0:(READ) flags 0x80700 phys_seg 91 prio class 2
[Tue Jun  3 10:03:35 2025] I/O error, dev sdd, sector 9830165568 op
0x0:(READ) flags 0x80700 phys_seg 16 prio class 2
[Tue Jun  3 10:03:35 2025] sd 14:0:4:0: [sdd] tag#1894 CDB: Read(16)
88 00 00 00 00 02 49 ec db 18 00 00 00 88 00 00


>
> This drive does not support CDL, so it is not that for sure.
>
> Please also describe the drive connection: AHCI SATA port ? SAS HBA ?
> Enclosure/SAS expander ?

It is SAS HBA.
It is worth noting that this disk has recorded 46560 power-on hours
(approximately 5.3 years) of operational lifetime.

--=20
Regards
Yafang

