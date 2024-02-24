Return-Path: <linux-fsdevel+bounces-12656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F08862348
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 08:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A7F1C21C79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 07:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018510A19;
	Sat, 24 Feb 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ooa8ZtIo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F66FDC
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708758585; cv=none; b=McnVLG/35VgiTeAWiej5euycTdNrc4J9IVVZhR3lKQi8X4zzD81z4OYOPnv7du7Banlha6W/eAX+Lc9c6ILSkkWC+kOtDBhGWFYdV4pp0DdxKZ7Pzq/aXEdEa0dBCoLDa6XokEkQF6JFNAs8ZCzHcWZdq/9uaRWhYKuwAo1Z75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708758585; c=relaxed/simple;
	bh=FS5a48cl+Y2UgFPwjUFdZ+pz4ft+Jb/eaejhJVZHKJ4=;
	h=Date:Message-Id:From:To:Cc:Subject; b=rpqw63/1O6t+4hFcEf3P3+Et9j5jI3ifv4lFyGxnzON3ZXzrbknKH87Ixr6A8SngbrcX9F2iDvx+YpAd+kRMp+M0OBCZv4jU/WGnApBST/+mWixj3yUomBP7gYpy7P28pc0uh5VLPLZyqF6tRoLNMdf/FLoYqDH/tUR7UdcD1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ooa8ZtIo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so1301490a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 23:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708758584; x=1709363384; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kY4nVmscRzo8yi7kdgmbEtUSrJdfw4v79rcqJNCN4Y=;
        b=Ooa8ZtIojFveOCLBGb83YjaEKepNNb0R84o5q+zCMwdvJngZOs6jiGsh7vAGzEcFVd
         6/KH+63AilOPIZchw4F3WGgw9oVtspaDoaXrhC9V08U0Zvo0Iq+U2sGsuPM3m8TwJyBd
         UUHDT/95WM6kfo2i9yvizf6JgZGAFLYYHRRZL95UpMUwyiI+RB7vsQxFW8gSQ06bUKkd
         5I5JMWcfANbMnHh3c7cQ/Kdem4Fzo/eqWYgfSb2UjbbF7P8GJ7kDSNog6JrWSkl4sS83
         qZwDezlwKutil7oL4Y6GYJh8RPWnq0IgWK+2Y/Z+vatCQiP+Daxzi621aPJm0eF0cg2j
         H7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708758584; x=1709363384;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kY4nVmscRzo8yi7kdgmbEtUSrJdfw4v79rcqJNCN4Y=;
        b=f4YPsxvrVGQJseB6DlrzIXBKnAQlZ9VxMGRCOpUtDgw0rCFSZKAXprSNYXkcmdDeJH
         Z/99lQfPjRzy3vNcFZJyt22ZfetXlwJqimnXa8Qxl8+vLRdqDHG4qcu4TEpAzL3pZkvR
         VodKUEKC63+kKSk9js1O124lFWJy/saZpJ35X/sEx1aFxbz9hyURmySyWi2XFXl2BzL+
         HK+3Bqed2T/YzvYE9IyZ5EAhNMiGABNF9i4eTDsCNwHp7py5ENyLnRdvfAxLj2hRQQZT
         TRogecQIn2qJPCWSiD2pkGNGHJQYmpgmfp2O5GZ8VC6mJAVoKXcg0cbIFPRPo41Bo5e2
         R/ZQ==
X-Gm-Message-State: AOJu0YymfB4H3WvMtymiQ6EVDpfGQiy+tRzyJLkgzIZdrQW14hk8JheV
	FMqeea3DdZPxYuPMy0JUxqTycP48tMRQ/Ln+hWpy/VM9AUBQLWe3
X-Google-Smtp-Source: AGHT+IGhv2pA9DJbbXmYIv+KKuXo8ow8WgG7ONKfiipeA683T6ec31lfeywg+D1NcT8Bkl63eGPG0Q==
X-Received: by 2002:a05:6a21:918c:b0:1a0:cd54:6d9e with SMTP id tp12-20020a056a21918c00b001a0cd546d9emr2285052pzb.24.1708758583622;
        Fri, 23 Feb 2024 23:09:43 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad3d000b0029a54e43073sm634633pjw.30.2024.02.23.23.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 23:09:42 -0800 (PST)
Date: Sat, 24 Feb 2024 12:39:33 +0530
Message-Id: <871q922v9u.fsf@doe.com>
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [LSF/MM/BPF TOPIC]: Challenges and Ideas in Transitioning EXT* and other FS to iomap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


In continuation from last year's efforts on conversion of ext* filesystems to iomap,
I would like to propose an LSFMM session on the said topic. Last year's session
was mainly centered around documentation discussion around iomap (so that it can help others
converting their filesystems to iomap), and I think we now have a kernelnewbies page [1] 
which can provide good details on how one can start transitioning their filesystem to iomap
interface.

Note, ext2/ext4 filesystems direct-io path now utilizes iomap where ext2
DIO conversion happened last year during LSFMM [2] [3]. I have also submitted patches
for ext2 buffered-io path for regular files to move to iomap and thereby enabling
large folio support to it. Along similar lines there are also patches around EXT4
buffered-io conversion to iomap.

Some of the challenges
=======================
1. For EXT2 directory handling which uses page cache and buffer heads, moving that path to 
   iomap has challenges with writeback path since iomap also uses folio->private to keep some 
   of its internal state (iomap_folio_state).
2. One other thing which was pointed out by Matthew is the BH_Boundary handling currently missing
   in iomap. This can lead to non-optimized data I/O patterns causing performance penalty. 
3. Filesystems need a mechanism to validate cached logical->physical block translations 
   in iomap writeback code (can this be lifted to common code?)
4. Another missing piece from iomap is the metadata handling for filesystems. There is no
   interface which iomap provides that the FS can utilize to move away from buffer heads
   for its metadata operations. It can be argued that it is not the responsibility of iomap, however
   filesystems do need a mechanism for their metadata handling operations.

Proposal
=========
In this talk I would like to discuss about the efforts, challenges & the lessons learnt in doing the conversion of
ext2's DIO and buffered-io paths to iomap, which might help others in conversion of their filesystem.
I would also like to have a discussion on the current open challenges we have in converting ext2 (buffered-io path) 
and discuss on what ideas people have, which we can consider for transitioning ext* and other filesystems to iomap. 

PS: As we speak, I am in the process of rebasing ext2 bufferred-io path to latest upstream kernel. 
It's mostly done and I am also looking into some of the open problems listed by community. 


References
============
[1]: https://kernelnewbies.org/KernelProjects/iomap
[2]: https://lore.kernel.org/linux-ext4/cover.1682069716.git.ritesh.list@gmail.com/
[3]: https://lwn.net/Articles/935934/
[4]: https://lore.kernel.org/linux-ext4/cover.1700505907.git.ritesh.list@gmail.com/

