Return-Path: <linux-fsdevel+bounces-40985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E140FA29BEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AA718888BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B93D21505D;
	Wed,  5 Feb 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vvm7yBb8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0523CE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791612; cv=none; b=FvEoFR6mlKAM4qHY2n3nXxJ9lNZ5mGhkptyMig9cr73x5qMxpAmbVWWLWBfz1khuRwT33RhhBShHhvsYz64UnFNsqPzrxDCPZR09giO7eBp775NdlZlNyXB39bRRdMRIXlREmhBN8hO/lTkl567kkq8cI+zZcsSXgiLQjcp3Y+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791612; c=relaxed/simple;
	bh=p19U8mO6OOoqPEZr+0BIgQs569D/QJnlO9E6zfbWCx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnSaBmRh7BPBhGEV5uFxCmDZ93ywbzts1edmqLfTYOfy/K6JmO6Hhikfp8kblc56ic/1s3uxtDV7sACbg4PROMi6gD+x8Yp+giVx1cys3/Rum4/EFt2Smyu6EP6Ntx15BCAvmljJotVhsNKf75nYG+GlvP5NzICS4rcpJZGj9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vvm7yBb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738791609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KQZJa6Aff1+CJwLmZWFTHMec/5G6wl4KmI4ceY4ir/Q=;
	b=Vvm7yBb8rKPg6krd16ORHnZRv1heTKhknVV3rpRgWfZEJPrb+EUVN83dnqkvd5fNNxsqlQ
	BybMb7sZk2nWVvdlKbrsSEOtxphVRGYb7WllHWlmW00+lC5PwJ013XFWE1uwm0Hn/pSsUt
	om4c8XO07f1DCXh4tmnuwmEkZuKCljM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-yU30ypcHOMahHaxdvg_jGg-1; Wed, 05 Feb 2025 16:40:08 -0500
X-MC-Unique: yU30ypcHOMahHaxdvg_jGg-1
X-Mimecast-MFC-AGG-ID: yU30ypcHOMahHaxdvg_jGg
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-851fda72550so53383339f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 13:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738791607; x=1739396407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQZJa6Aff1+CJwLmZWFTHMec/5G6wl4KmI4ceY4ir/Q=;
        b=f9GsYqI4D4DDLftyfLPCVouJe6XrhhoJqD1JFoUgdXol3JLG5blyE9TBXSd/Cy6iTv
         f2KHX0TVL4smJ3thcjo+C7eOgaei71epJM5ZdQ7r0nCLLswwBQ3P9p34ufokEd+/3BU7
         PML64bh2sm7zDYi8TUAxYZ35e+IawUfCT2hzhyxAMjL4jSKFVTqQYU29tRYy/0Dbfh9Z
         EFTCsCnETHH5Jtw3oEpLpQ0Lpuko3EnSoGcNMTL6MU6WDYqK6Jl6VS+HatsQjzyFrslo
         +Zyb5aICDU+q8AY3PQwYxogmnIZPx9AEhFu1zGfSOTW/QR/QAZeo05a8p0/dF1Uh0rDe
         ie8A==
X-Gm-Message-State: AOJu0YwdckT4p8xRZtHOcBJ276G2KyvUmENPib8VOCQR8dNlzmqxgYre
	i9zFIJwbWwNaSVzNlbOimNtTq5Z5L9GsgA+KkAKWLiX7pl/lWg/vGLQ8ZVJpcR1Yq4rtvdGYFy5
	QXL9ysRxAZIN+siUPDqXPC3+mpLQw/ftKpn1Jn2fWxXjvRIQtijBufstQzhIaQ+CdJ7ZHr+LhnE
	uWxIX16QniwPpSwrLaC5m+gYVN4FtPaJv/tzV9To5hCc78vHLM
X-Gm-Gg: ASbGnct67DvJgvrxAsff/n/02krSuCDJXQ/ARLk4sP7KgF4zj0e2J9/X32hS9scygiJ
	C+pfvS5tyTDOlHK/1UMb44MTRZzQFGRJnlk8frkF8Zi/01C962lQejx8A/GLR7QGbtAeli6YxyU
	bwTRhqGOci0kuepS7u0F4egBsB3IJx/1b4nR8DehItXEnsNmF7Bg71YQtXdkIWdoPyb82pfDT82
	dyDRoehG5dY4bjpO5tpRYs9o8UK3ftMTeEo2hQlJC2ZmWNZQaciVgsOYQGiMS1TOuOmatDPChzs
	150jszRQkBb80gh74iNf7NAL8wbOJgpSg7BPVXIiboo596OgZ7v7Rw==
X-Received: by 2002:a05:6602:3e91:b0:84a:7902:d424 with SMTP id ca18e2360f4ac-854ea351931mr477937839f.0.1738791607409;
        Wed, 05 Feb 2025 13:40:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrCXnSMJixvqUjYFEbU9k45b0a2t+hiYmDkSSyAUPMIjZzaIvJA8lljpjeDIbToKuG1nonfw==
X-Received: by 2002:a05:6602:3e91:b0:84a:7902:d424 with SMTP id ca18e2360f4ac-854ea351931mr477935439f.0.1738791607065;
        Wed, 05 Feb 2025 13:40:07 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a1717863sm368050839f.36.2025.02.05.13.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:40:05 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	neilb@suse.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	tony.luck@intel.com
Subject: [PATCH 0/4] fs: last of the pseudofs mount api conversions
Date: Wed,  5 Feb 2025 15:34:28 -0600
Message-ID: <20250205213931.74614-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notes:

pstore used mount_single, which used to transparently do a
remount operation on a fresh mount of an existing superblock.
The new get_tree_single does not do this, but prior discussion
on fsdevel seems to indicate that this isn't expected to be a
problem. We can watch for issues.

devpts is just a forward port from work dhowells did already, and it
seems straightforward. I left error messages as they are rather than
converting to the mount API message channel for now.

devtmpfs was already converted, but left a .mount in place, rather
than using .get_tree. The solution to this is ... unique so some
scrutiny is probably wise. 

The last patch removes reconfigure_single, mount_single, and
compare_single because no users remain, but we could also wait until
all conversions are done, and remove all infrastructure at that time
instead, if desired.

Thanks,
Eric



