Return-Path: <linux-fsdevel+bounces-41895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA416A38DC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 22:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF628172314
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681E238D42;
	Mon, 17 Feb 2025 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbTSHqx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9587A22E3E8;
	Mon, 17 Feb 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739826084; cv=none; b=U6tJA9HDAKTgDwp6GWaTIQM+bB5FpTNSlOW9S1kGJkpFjessjMXB1sEAeiex3BcAd/5FKkf9HCTsLS83IF55DoMKmFARVbEXFENOR2swnPm80YebxK/NE6pzPHejyXY8BC68+03WMzuYAMc/XK8plpDY4CETa8WyIljnpcMbMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739826084; c=relaxed/simple;
	bh=IxqckOh4nhK1R+8H6Su9duXblVNC8h7aTOP3J3yWDhY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gGVyX2kDHptGZZqNP3UVoqMXBmeh2LGw1qqKQkERHMvWfEPvIxiySbS+fphL3O1YrRvmTJRc91WEzP1OWaNhddFD7tk0eSxZo48t1CuCeqvfVscfd72BMtbmHtj1gTSr4TlJcwz7HvbNvXXyAVqrBOS1xSshLF16Oin4j/sebHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbTSHqx2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so48853781fa.1;
        Mon, 17 Feb 2025 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739826080; x=1740430880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EL7W6YewL+3ISQgqOrnJFOtMZVgfdXA7Tkj9u2lqeWk=;
        b=RbTSHqx2TMt7lVUR02q1OcRWsd30L+V/mWW64n0dY/AV5eAz/5K+892f/NUPRQIJKP
         X8y8tDDihc32AQHQYVcr4bHqeeQmxAOmc4Ya9FyNh0wa0u/2lvFVASasPzT9zaMBcRgl
         1fJbRxYUGjLiZtifHMREbfC9RtJbLcqpbYH2Tc0Xa63yY03B4RlDWN1J8gzBQPW4pV/V
         Haz9tLhZ4mnEN2Xbh4P+R+dTBV7o5h6/p7az+FaTgOlFndFHSkd8uVCDuGL8g68AY3S2
         H+Ol11GbrYV2c3BBcO5fS5Epa9iG51zQUJwBg6YZ3RbozjOAEJARsjXwadZUCAEquSrc
         uoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739826080; x=1740430880;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EL7W6YewL+3ISQgqOrnJFOtMZVgfdXA7Tkj9u2lqeWk=;
        b=nxEwx7XNM6E2Fyy/lQ3KcW0RrX0UPn0VCD5pvIg3uiBzNskylIbrlarw+ii5mxbpQj
         hDFG7XX1ivrXA3oUkLOVxfvHjKyVZROcckSe/4HkroTvqyFG1jAiF97FeM4g4kKy9Jo0
         eP1Is73/REg6tXDmkGG/Hj2ve2E80zxr7riKTKiJL08pPGoDdlFGTpQSFMNr8QlkfP3z
         IbybYg0hMe3S7VS3Yo4Vmy3fQirH7gVcCQF88QRtwrgjB6fOrcFxuSsWKPzpR9eTR9/7
         GM7ZsYTslaOsLQneXWqinB/IWifTtxK/Px+BKj4aPNPP25EmkcA89LvMyIaatccsRaG8
         OyqQ==
X-Gm-Message-State: AOJu0YwnYKr9OgFvaTgfRCK0rOFeaD2Nph4JA0YsywgAtx3Qw7E6x3ij
	JUSUXWUDq49FvggjHcfxWsWVUx+A3MmNhjBv+JCPSPKrH9Iw7V1NaZ5YXdvvZHOEuvfjO8nOUsc
	njbnbYqjG892rA4mPqVon7h0U+5mWmLxq
X-Gm-Gg: ASbGncuvV+duADPtnmacRXEb9kVdG+qqFWyBxBAJ1zvryxd1nmNCaJT9hRl6uU/DZXV
	+bd0ss5SuKFL3rRn4VmaJ/mPdS02it03VR6GwgOWSoDVMBJ6RnNZBu/X7+5M4ZSK/s1f/9Lo6m1
	g1JBPQ8PS8ARNtzeLlFJLLwG2OAOVsvqE=
X-Google-Smtp-Source: AGHT+IHrHDZZumHsnKYmG8osWpbY1PNBpPjNzCUVlT3Og4VLzSMxH4RbhZz+AbNuaYKlOwcFy9vfVqEkXagahTO3VCU=
X-Received: by 2002:a05:6512:b27:b0:542:a73d:a39c with SMTP id
 2adb3069b0e04-5452fe8fd1dmr3516096e87.49.1739826079507; Mon, 17 Feb 2025
 13:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Mon, 17 Feb 2025 15:01:08 -0600
X-Gm-Features: AWEUYZl2yITVdAEbPXGQn70Hs2GxiJtUAhhANCfICUPFJyryxu8ZnfiJvcFpA44
Message-ID: <CAH2r5mvgkPdLQ_oz_faa=4CVCaHNDcNVZfqBbdKTENrW5COSTA@mail.gmail.com>
Subject: netfs read failures with current mainline
To: CIFS <linux-cifs@vger.kernel.org>, David Howells <dhowells@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I see many "Couldn't get user pages" netfs errors running cifs/102
regression test (which tests for leaked file handles) when using
current mainline from today (which includes the recent netfs read
retry fixes).  For example many of:

[Mon Feb 17 14:08:31 2025] netfs: Couldn't get user pages (rc=-4)
[Mon Feb 17 14:08:31 2025] netfs: Zero-sized read [R=32f]
[Mon Feb 17 14:08:31 2025] netfs: Couldn't get user pages (rc=-4)

Anyone else see netfs problems when running with current mainline?

The test does the following (checking for handle leaks):

# Create a file to test with
echo "hello world" > $TEST_DIR/leak
# Try to kill a 'cat' when it is opening/closing a file
(for i in {1..5000} ; do cat $TEST_DIR/leak & sleep 0.0001 ; kill -9
$! ; done) >/dev/null 2>&1
sleep 3
# and verify if we have any leaked filehandles
smbstatus | grep -i Locked -A1000

-- 
Thanks,

Steve

