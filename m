Return-Path: <linux-fsdevel+bounces-19276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4F98C23F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1081F258D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C18717108B;
	Fri, 10 May 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEBnEjv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C316F26B;
	Fri, 10 May 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341814; cv=none; b=hXN3airviY4xsmIqVWX5W6/COGTAW9GHIGyKIur0LL2IU/uC4klR+UaukBvEVAhqQBgECH23MfvOYlVhbZqdTsPljgB7cvQe5Uu2mDtqBjYsk/63uiZ5ZPzuhywCmuhHhS3sqzRzwz2ewd0UlztsQCkE7bmJK2PDpGewjWnNeng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341814; c=relaxed/simple;
	bh=i4h+33ayWNxAxzC4LjdAPn27sgSSgKXxUE3iazZbtVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvNzzPzvkANKWFJiYckroqJA08hMjipb4jySLmoZfOknbut8uoq9w/ogUcW8wPfSZtTQEq/Uv4hpziFapep8WToSD9jniJ3bhhbNAK79UAgkjipRdCOkeq+ibjlX3lm1IYOjSfBz7omczSXESoP9x7L+I7TqjHwSYUVZEEuX1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEBnEjv9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee38966529so21357635ad.1;
        Fri, 10 May 2024 04:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341812; x=1715946612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SKkpoPGaGqkRG+GvEkaimZUGHi7Z3i5I8Zq2egM0XJg=;
        b=cEBnEjv9cMNz+j59pbJ2Ws+rusWfP9epVu9C1Ays6zaqH0HAbHm2CzuK1K18cCpzJl
         XWLOq4+Bl7evRaj7Nen+1xjWYfgdagcgKIjmerP2Xp58qGNArpEelYNwzPMM2j+cBfju
         /64A+mr4V4+eujBeWzi4I2qDlrh/brH78ahP8EpJwfze2FSYEL6GMKB1vRw8MBtFqeJh
         oWx2Oh4CsHfTpsV3JReK20yGzMS++EYGsMzerWyhz+05cPQfFV0NR5NcDL0HVNYMaQYJ
         snWPEQbm/2ki4YWkbwidKvK0fol9y3nYOMnvyXV81blnbXDPRB/RJAhP2ALRmv0ofllC
         5ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341812; x=1715946612;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKkpoPGaGqkRG+GvEkaimZUGHi7Z3i5I8Zq2egM0XJg=;
        b=G4fMOtNbwU/3VTCTy4K9TPey+kkfGLeh6GUwOnHs6AbQKAaELSZrlh205KnNmpquts
         TuGEUEQphsxaxKYM0tCRVgn4V6hPyH/uMgttccPNAxGrn1nut7Vxsm4rtoypZNJWrWLm
         sU3P4hcOY62J/iY1iVXHJ0SW+bhd+E6SbXoR/eZa5PXg7hhrzXIVCz8xe1QM6oIds4gP
         6NF6hvfHBX2vhBy04mT+qKM64pliKKv07Xbg/UJM6LTJv3q/8y9K0CqYUqgmKbjVWfcJ
         J6Cg6WTYvQPsDgjx0WKgm+6vNw/cabmcsJvReylbShQVRC7BMMIS+LdFTZQYWxpn+FLs
         Eb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9vI13eCvSKxqBbSFOTLcScZhyotThnn0r3Ea7aS6jLuPxt1Hp2TIBizllR4Z5VBaj5nV4e1rAOlGiFTswRt0CMCMBNq7SrVRp5WBMH8VwHdJtbNz0qvQnu/rHY2D63BXRdD7Eftb24EE1Bw==
X-Gm-Message-State: AOJu0Yx4NqOYEmmjrjveB5OaGjkQr3vLVrmWPxqVDEet9jZ8Eh0WjQpE
	SGFn1kkVcwOQg1OqNkY+ztKaCm9t1AlKNCu6wKB4OEKLmcD1MQP4
X-Google-Smtp-Source: AGHT+IFQCmuUzZejhKR+NA0CyPkuBm+fZ6cTTLFHyaCrgsSueVY92V2AUpJszgttMrtwpUbv0gZENw==
X-Received: by 2002:a17:902:cecc:b0:1e5:1041:7ed4 with SMTP id d9443c01a7336-1eefa12f408mr84798105ad.14.1715341812566;
        Fri, 10 May 2024 04:50:12 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.50.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:12 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: [PATCH v5 05/12] cifs: drop usage of page_file_offset
Date: Fri, 10 May 2024 19:47:40 +0800
Message-ID: <20240510114747.21548-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510114747.21548-1-ryncsn@gmail.com>
References: <20240510114747.21548-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

page_file_offset is only needed for mixed usage of page cache and
swap cache, for pure page cache usage, the caller can just use
page_offset instead.

It can't be a swap cache page here, so just drop it and convert it to
use folio.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Steve French <stfrench@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Bharath SM <bharathsm@microsoft.com>
---
 fs/smb/client/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9be37d0fe724..388343b0fceb 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4828,7 +4828,7 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 static int cifs_read_folio(struct file *file, struct folio *folio)
 {
 	struct page *page = &folio->page;
-	loff_t offset = page_file_offset(page);
+	loff_t offset = folio_pos(folio);
 	int rc = -EACCES;
 	unsigned int xid;
 
-- 
2.45.0


