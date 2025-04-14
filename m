Return-Path: <linux-fsdevel+bounces-46403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA26A8895B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 19:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836BB1894350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EAB289379;
	Mon, 14 Apr 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f2lDbJsP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA20289363;
	Mon, 14 Apr 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650437; cv=none; b=NKNAUcJHz5HTt4CtLbsNET0AIHoSmtvbW6jzC6T9F5UW2m3pmx3HNkh2mtDJX82WGGq1vQVb8pxfqqLN5nxsSHSH3Ne/RBuSDb+yCMSi9E4fP+4L3Cu1khNnSzab2GWfD2uWShE5HLM53tErLvnz2C9eae9/wx/Lka7yv5Tkj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650437; c=relaxed/simple;
	bh=CsgVFLGmNwx4Evvrq0QehN2SxQ2ECah/iZwmqTAGGnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLQyuVnM5b9e2yTWHA3bOwM0nKkWyUo9Zix7vgD1iigX0wKmtGwCUmwvpMNYv8ZDz6KeaCpYP1IN9e3eXpJiqAuHcBRCE7YLHW7eF8OgiPGGrQEjOtVYANLR4glrBgH1QStedfWRgpgK4vUkyjfHscuM+3ngBndWP4KKzoNha1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f2lDbJsP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2gZHiQsHwL/1CiwmoLxA/AKtozhwa+CHYwI4fFRQqD4=; b=f2lDbJsPSbSJtQwgU1X7g0nVIi
	9h9v2a3vo1nXbNLnxtmEOv4CV8S6WoVaQwWKxrJ3BiwSlCMRCLUUWJEBfPBk35I8j/fJqCM2RW+gY
	v26pydDIrLOfzzXVZI9R1W/YaSh2HNpwFWJ54oxV4kvCXdMb0TxX1fe0I6GEsv9MSx0NUtX8vZMtN
	Q74BWEq6jTbc57vMItbfAIKgGp5VZ1cNO3dpxdVrkvS9wLKxg43qKXmH6fEOqo2gR1sJhf5rB/QqQ
	VdRxKvcymsxfvvPlZ5tnA3BTxnQQLRe8qIMujwx8FI9indxcRNLc5w8jPgDvHcSvspZOHN1+YxXZC
	PFsXX2Bw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4NH6-0000000Aw0B-0Ywm;
	Mon, 14 Apr 2025 17:07:12 +0000
Date: Mon, 14 Apr 2025 18:07:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Cabbaken Q <Cabbaken@outlook.com>, Kees Cook <kees@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] Fix comment style of `do_execveat_common()`
Message-ID: <Z_1Av3LPtQB-Fvqe@casper.infradead.org>
References: <OS7PR01MB116815D7D0BCF55F3FE216293DFB32@OS7PR01MB11681.jpnprd01.prod.outlook.com>
 <hsnabzbrvgpng7rsxpgcjaggiwaenrgwsi2u7spfbypbfraymu@7h5dxvkq64hz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hsnabzbrvgpng7rsxpgcjaggiwaenrgwsi2u7spfbypbfraymu@7h5dxvkq64hz>

On Mon, Apr 14, 2025 at 03:58:37PM +0200, Jan Kara wrote:
> On Mon 14-04-25 07:07:57, Cabbaken Q wrote:
> > From 46fab5ecc860f26f790bec2a902a54bae58dfca7 Mon Sep 17 00:00:00 2001
> > From: Ruoyu Qiu <cabbaken@outlook.com>
> > Date: Mon, 14 Apr 2025 14:56:28 +0800
> > Subject: [PATCH] Fix comment style of `do_execveat_common()`
> > 
> > Signed-off-by: Ruoyu Qiu <cabbaken@outlook.com>
> 
> Thanks for the patch but I think fixing one extra space in a comment isn't
> really worth the effort of all the people involved in handling a patch.

The correct number of spaces after a full stop is disputed.
https://en.wikipedia.org/wiki/Sentence_spacing

Do not send patches to adjust the number of spaces between sentences.
You are wrong to change it.

