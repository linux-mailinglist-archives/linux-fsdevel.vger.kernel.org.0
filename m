Return-Path: <linux-fsdevel+bounces-2439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6A7E5F62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D024281511
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675D9374C4;
	Wed,  8 Nov 2023 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="deCbd0oP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33C37161;
	Wed,  8 Nov 2023 20:46:22 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F27C1FEE;
	Wed,  8 Nov 2023 12:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=rn/d0Ff4UKa3gs7pNPXO5RWAMhcbCt2HT1oiR862Zd0=; b=deCbd0oPgbpt1IokwXDbkLolc5
	NLgkJCrkDmGuxbvcPZ+yaHkjFaGhlh90AStzXUZWxtI0nsOMq9foe21jfjJRL+ftM+camH30vvNsx
	rYFRqskZR1Lr17wcN1CLX5Fsvu7GNrPAHcWjScumuQqFr4YgZe7Gh49spU6uQzgzDtkJCuMKxoKsn
	EqYixTnaF/ivfKb0XJdICeqieCMnPYmunEi2ey0ntCeHcf7SKZqP/SnM+TnDhVDHpkKPdJ6YrKnG+
	cWtbJeuFbEejOjlIZ2TMFAgPbJkIwCqpJmzv7ZDn2RRxJhhHjdmpzaAulNWiZioZ9ArG6GirAKeIF
	7CBybXFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0pRB-0037q2-67; Wed, 08 Nov 2023 20:46:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] Make folio_start_writeback return void
Date: Wed,  8 Nov 2023 20:46:01 +0000
Message-Id: <20231108204605.745109-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the folio flag-setting functions return void.
folio_start_writeback is gratuitously different; the only two filesystems
that do anything with the return value emit debug messages if it's already
set, and we can (and should) do that internally without bothering the
filesystem to do it.

Matthew Wilcox (Oracle) (4):
  mm: Remove test_set_page_writeback()
  afs: Do not test the return value of folio_start_writeback()
  smb: Do not test the return value of folio_start_writeback()
  mm: Return void from folio_start_writeback() and related functions

 fs/afs/write.c             |  6 ++---
 fs/smb/client/file.c       |  6 ++---
 include/linux/page-flags.h |  9 ++-----
 mm/folio-compat.c          |  4 +--
 mm/page-writeback.c        | 54 ++++++++++++++++++--------------------
 5 files changed, 33 insertions(+), 46 deletions(-)

-- 
2.42.0


