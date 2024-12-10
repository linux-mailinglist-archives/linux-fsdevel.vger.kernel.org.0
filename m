Return-Path: <linux-fsdevel+bounces-36921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D5F9EB006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A1160712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB52080DD;
	Tue, 10 Dec 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZV9af/Po"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC11DC9BB;
	Tue, 10 Dec 2024 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830733; cv=none; b=RGt9JkDLII+ujysyPOaVeDMb/iaAEfUHhVgMS1cHGs18tYKgSO3CoV+9JLcE0NGSimimew+ptAmfNrsCM7pjv71zYg1WOZ5C9KRgSBdYH3K0AfJq9C43p8mPIayCJUgumTbDoDAcEGSePf9/zjDBhO76AycyQMEqvpxiM8PNtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830733; c=relaxed/simple;
	bh=4ADZZ+SdRCOebMi0Z6ACPt5agLAalg67mOUA1BuUnCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGqpsCOkVGdfx6E04OPuk+Ew2eokgjDwIFrKss8V5iLV9LvTqKplOniuQ29ML4vlf5tGwaLfLhAvlUGnK07zcnRzIzrI/nCSKvq/ZBhjcMCIQreskQptMdhOV7sjNd6/IljP+rXdr+//ju/EzfFWLgFUUqsWDSCJi2trUVB3/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZV9af/Po; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D4i3M+zB0TPDgkxcNa1AEGCPUDGtCuiRyT0Ol+xlofo=; b=ZV9af/PojLeJohKlMCGwY4E4Sp
	X/wz6biAeQOUxBtbaiq0UmN8odSVxw2NfKdSFLJ8QlVYH7r6MAFapbdWFIhptiLzIECtLjVmmjaaF
	BIVwEMW9c8asp6e3tij1uJ4a0U1WziQitfGoEzqldQjl35prbH/RsSuXBfRLzU8HQwvcPfQG+nubU
	ZaQGRN02L8AMwBnHCFxakc57kIkuGleWd8+PSAzRbHMPx+QaF1p+k+Vef05g3IEHa0TIQn6chR1aa
	yWL8fe0GO5z5iM7qJsianbYtNjnYZTukwsoBy6rQg7zOSrLxyZ9zyHwjSl9wNVxCIdOIARkuURojb
	myD4sPBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKyZk-0000000BL1f-42gS;
	Tue, 10 Dec 2024 11:38:48 +0000
Date: Tue, 10 Dec 2024 03:38:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: djwong@kernel.org, cem@kernel.org, Long Li <leo.lilong@huawei.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v6 0/3] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z1goSBpgKTydaQAV@infradead.org>
References: <20241209114241.3725722-1-leo.lilong@huawei.com>
 <20241210-strecken-anbeginn-4c3af8c6abe8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-strecken-anbeginn-4c3af8c6abe8@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Can you please drop the third patch?  We'll probably have something in
XFS that will conflict with it if not reabsed, so it's probably better
to merge it through the xfs tree so that everything can be properly
merged.


