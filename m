Return-Path: <linux-fsdevel+bounces-37843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97429F823C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AFA1654C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1977F1A9B28;
	Thu, 19 Dec 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yfC/90fd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C61A727D;
	Thu, 19 Dec 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630001; cv=none; b=pr95gzA8BErqGC1ehctZfqvcQFxvDhaef3+oUINEhuqp6o7DtgdcmQlP8lVpiBL4MNDmWg/m8PEg6vTPwrx5o0IPUTY7I6bDxdoorAwcPVA3ws/lJo7d5xGS00IhyeSgWXX036pN/ebvopBMuqQGv3ifIbH+6xJq1jl5HW855XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630001; c=relaxed/simple;
	bh=Sm7EyHziSukCA6Jq7Dq9xan3h6rv2XkVMxPPaFNT8cY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L82+jOeRp+TcET8FsqDpwJNeykYa37NJ5djFaZx/gRSU/0UMTBggEPye42FrqA7K0VvSrCByzVr6Qqr+qbORh1UPd4DZOYJb1SxjaSNIVcSEbZoTwdb79BfFBEk6xBb5J9lrg3mP5Ct69SJKVYjV0s74y5OL7KaDrT/q262q2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yfC/90fd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wlhbNKOEeZhJRK52qotea+lLlGi0IsmKVdZXS2TXImc=; b=yfC/90fdX/X+vAEg+ZvlnRJaMs
	QhfmtmCjtVtmM10A5oY+2Sn+TfpU2a34Tp4xygmtLYfkPnuTEmFnS2ERf6fyTJobgSsd9fqcA1xNS
	8jCXmGbkkrxoUWg5EX3B39aPdqXqSbQIgwbAmWDASbud8hV5yV1EA8IR16i9Yit7qIREeNXh0op3+
	sNuqjs60BZwvlPe5KGjnQ0JIJDs1SmaSUAXi4zqNAtmT6BjhmIcYO/34iny8Ha80V3BdNAe13pfkp
	o2Fa77JMsdbm5HFrrBLkc5+P8nsgCNw1MqLDFatQPB7qGl7w6dvIbIsSeb+OmaS9M6NULsyDmuSNS
	ntDkw0RA==;
Received: from [2001:4bb8:2ae:97bf:7b0d:9cbd:e369:c821] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKVB-00000002aua-38tZ;
	Thu, 19 Dec 2024 17:39:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: iomap patches for zoned XFS v1
Date: Thu, 19 Dec 2024 17:39:05 +0000
Message-ID: <20241219173954.22546-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series contains the iomap prep work to support zoned XFS.

The biggest changes are:

 - an option to reuse the ioend code for direct writes in addition to the
   current use for buffered writeback, which allows the file system to
   track completions on a per-bio basis instead of the current end_io
   callback which operates on the entire I/O.
   Note that it might make sense to split the ioend code from
   buffered-io.c into its own file with this.  Let me know what you think
   of that and I can include it in the next version
 - change of the writeback_ops so that the submit_bio call can be done by
   the file system.  Note that btrfs will also need this eventually when
   it starts using iomap
 - helpers to split ioend to the zone append queue_limits that plug
   into the previous item above.
 - a new ANON_WRITE flags for writes that don't have a block number
   assigned to them at the iomap level, leaving the file system to do
   that work in the submission handler.  Note that btrfs wants something
   similar also for compressed I/O, which should be able to reuse this,
   maybe with minor tweaks.
 - passing private data to a few more helper

The XFS changes to use this will be posted to the xfs list only to not
spam fsdevel too much.

Changes since RFC:
 - update Documentation/filesystems/iomap/
 - improve comments
 - make the iomap_split_ioend calling convention simpler and hopefully
   more cleasr
 - propagate bio_split errors
 - rename the flags argument to iomap_init_ioend
 - move more code to fs/iomap/ioend.c
 - refactor the ioend completion code a bit
 - replace the ZONE_APPEND flag with an ANON_WRITE flag

