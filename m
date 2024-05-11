Return-Path: <linux-fsdevel+bounces-19325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A498C3309
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 19:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C45C1F22446
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 17:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A11C698;
	Sat, 11 May 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/P6+3Y3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5ED531;
	Sat, 11 May 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715450030; cv=none; b=K8krpZq50tm556NCgbn5VQV9mHE6IgszbuC+N8hkmN6qLcN+DTG+U4r6k9b+qvcMbp5C2Es+UY9WEnEN9WpNrsgo3LmQclzoB+j3ftfIh+i9LtIC7qHEzvX+SgB+N8ZzN0nccfee17+EGs/0kxiWot10Eo+0vbUMwcQsXtWevRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715450030; c=relaxed/simple;
	bh=kalldxxxFW5AEoJSmwFR06nrpxFDcgX4HY5+F4DtPuM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eKb7911W3MbhaRthYds/XGcBGz27287YrNU0LNuNEV90uHuqSmJ2Ya9Dntcer1rEdgEKgYWSvBbgLm5enRAhTPeGhN2Np2p/ydCdXtu5SgdfR9ieMXiOY1BeEn0yMZLj1QmmiBYnj23Ju+JiPyPt8W8kRHHMX/qehJk596MczTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/P6+3Y3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f57713684so3678430e87.1;
        Sat, 11 May 2024 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715450027; x=1716054827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zx0P8izNU72gstI8gx5ejmZVT9EbRbkJ/pX4W8egZls=;
        b=N/P6+3Y3iW64ErVeWq9zudyruPIlWdIwzOYe8mptWO/2e6LAt66MmOjWEe1XR1ssqt
         ro3jBGM7vATVC01ID5zIA88txe/1tvXfDcMMI0sK0zg+eZ2JnhHbEJb0dvxI+Slyrefx
         Uch7W4Om4iBseMX8pmVoc1VMhCtx/DoWIDD7q2zGTah//t2wUgU2mTyA171ZcpglndZQ
         G1KP77kURkMSpy7rfzmIyjwB5uEc2yT1NF7WPzw/sr+J8xp9ISxbbUrsW7jNTcPR6OdW
         i4ZkRtKaATMcPaBG3o2C2cX9w+RN0/ygEoiokuixBJSD4uRGIJbDyehfm5H/fEVPjROW
         L0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715450027; x=1716054827;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zx0P8izNU72gstI8gx5ejmZVT9EbRbkJ/pX4W8egZls=;
        b=f3lQpDTUC8FQAD5sJMZ2veRdE2Mfj1SlLYehWdk7jIKv+IlqdPDJF/SkrxX/XotZLz
         tS+iu2QEeDwT/aRPqdv38X14Ygy6rVObJfvosdVRisg1T2L0n0pjO9JqpaJlsiwK9Kxs
         SFLXDzFuUgGu9keGVDgQPAkucqUVLqhKs8D8hxir5Ar1dqHHNZAJVhOcCnb717vdPOSw
         sIw0/MHs/1QEUwjl6dtHyMUbDnJ7dA2vcR3WTgAyUD0UwPA1343R6D+oi6tXXjy4YGTh
         oUsMlOcbzeFa44biNxDE4RuZfWYyGzLT+UZMvm4sbZFtnRB7utfwug3v3hhly8YsNkwk
         nH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlLE0b0i76ynNkmGEMRoaxnQ46GcVJvhuS24x7IMidMtG7D9Q7+l6oQ4iI7zaaPEW8K05ObBDk5Lwk1Tfw5iy5TQ4AaGLPSX1BZC/4bw==
X-Gm-Message-State: AOJu0Yy5QcJvyuhLZphkfExGCOdChgqLsjXegRpYFbY3gcPeE204VHpE
	qMNvjAbAWw21gJ9sjUMA3qXW1f6VveNH6+1G2o/vEFYsnEUNQXMm9cb6SXHkXrStlPKnmGW/tw6
	tZzI8p9KIiv0qv1lQhL0TWqVGbuL+uVXn
X-Google-Smtp-Source: AGHT+IGiQapXX60FlQzepGQSjOfXD5SSzaSOoG4sUQiEe8sKGoe6T1vqYzp6Aq9xxaayK5K6uOfK729gZWrksKo3piw=
X-Received: by 2002:a19:5519:0:b0:51f:6324:4b77 with SMTP id
 2adb3069b0e04-5220fe79a8dmr3453681e87.49.1715450026365; Sat, 11 May 2024
 10:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sat, 11 May 2024 12:53:34 -0500
Message-ID: <CAH2r5mvvRFnzYnOM5T7qP+7H2Jetcv4cePhBPRDkd0ZwOGJfvg@mail.gmail.com>
Subject: cifs
To: CIFS <linux-cifs@vger.kernel.org>, David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Tried running the regression tests against for-next and saw crash
early in the test run in

# FS QA Test No. cifs/006
#
# check deferred closes on handles of deleted files
#
umount: /mnt/test: not mounted.
umount: /mnt/test: not mounted.
umount: /mnt/scratch: not mounted.
umount: /mnt/scratch: not mounted.
./run-xfstests.sh: line 25: 4556 Segmentation fault rmmod cifs
modprobe: ERROR: could not insert 'cifs': Device or resource busy

More information here:
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5/builds/123/steps/14/logs/stdio

Are you also seeing that?  There are not many likely candidates for
what patch is causing the problem (could be related to the folios
changes) e.g.

7c1ac89480e8 cifs: Enable large folio support
3ee1a1fc3981 cifs: Cut over to using netfslib
69c3c023af25 cifs: Implement netfslib hooks
c20c0d7325ab cifs: Make add_credits_and_wake_if() clear deducted credits
edea94a69730 cifs: Add mempools for cifs_io_request and
cifs_io_subrequest structs
3758c485f6c9 cifs: Set zero_point in the copy_file_range() and
remap_file_range()
1a5b4edd97ce cifs: Move cifs_loose_read_iter() and
cifs_file_write_iter() to file.c
dc5939de82f1 cifs: Replace the writedata replay bool with a netfs sreq flag
56257334e8e0 cifs: Make wait_mtu_credits take size_t args
ab58fbdeebc7 cifs: Use more fields from netfs_io_subrequest
a975a2f22cdc cifs: Replace cifs_writedata with a wrapper around
netfs_io_subrequest
753b67eb630d cifs: Replace cifs_readdata with a wrapper around
netfs_io_subrequest
0f7c0f3f5150 cifs: Use alternative invalidation to using launder_folio
2e9d7e4b984a mm: Remove the PG_fscache alias for PG_private_2

Any ideas?

-- 
Thanks,

Steve

