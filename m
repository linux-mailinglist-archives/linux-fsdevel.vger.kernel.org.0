Return-Path: <linux-fsdevel+bounces-29398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE07979503
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79AC1F23892
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73302225D6;
	Sun, 15 Sep 2024 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YQYyDrH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4036CDDCD;
	Sun, 15 Sep 2024 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726385169; cv=none; b=P6xklHzDlEegrBG4FBfEVeKoLPYSvdJoGAqem2OspcX4KGk8y8SKyl3pFms3Vg+MEgFnkJe3BOSINg7FXjEmmrJ2PdblqZ/AD7+i+jsrV70T+P1ny5ATVzXBHK1voTgXdF1owGfuLgS39kvpwJ7Iq7DmIEgBuY1uQw1MNY2K7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726385169; c=relaxed/simple;
	bh=4TTkIXqOwXjt3QIuhVO2i3CgfOgMOcIIz3DdvbdShDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1zHT9Yfx6KtdtVLj8oamMBMOo59hagTEbYQetBOu46MVnK2pBpzKBdBna0qcK44lE70PzFjZv2eX+4ILPpy7KdkghqQpTky9toNpjJFRNCmbX0lTFCR+RMSxAnwQhYYJdqddu17JSMex+a70CnPiCHtMvgkKXv2dpQsmxcts+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YQYyDrH7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hw9NdiIoFZEcIKCUQMz5Zk/QZV6yToYX+0ixrS3Dvqk=; b=YQYyDrH7DSsODvUG4D1L1rMKtO
	1oK49a/IRcWj5j3nGCCeHWwmFIWyVg9kqfTpyejINrKVwWIJDW3MkLeduz16bkDkJZPX8Hw8+W2rd
	2Dur7r4Eg/3QAW9fEQt6C4AIwmYRJimYNQMJUURClk5xKVAOozXx2/oyO0a3sOV2YRENR05N1mRZj
	8UWIFJKPU/0mSoa/LKTbQ+/IjquCEtrN+m7FeQhEtBJQGrFZtJtlDdrKlqc0x2H+f5Pv8FTGkMAbg
	/j37th+PKtTFzgTtTicTkA5YqP0ITkR1p0XS6Vcl03hn0rXWHhRrfTjp7wWdPjUgH1bV6SPW/tFZL
	hMAPqYsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spje0-0000000Ccj8-344Q;
	Sun, 15 Sep 2024 07:26:04 +0000
Date: Sun, 15 Sep 2024 08:26:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/exfat: resolve memory leak from
 exfat_create_upcase_table()
Message-ID: <20240915072604.GG2825852@ZenIV>
References: <20240915064404.221474-1-danielyangkang@gmail.com>
 <20240915070546.GE2825852@ZenIV>
 <20240915072336.GF2825852@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915072336.GF2825852@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 15, 2024 at 08:23:36AM +0100, Al Viro wrote:


> IMO it would be less brittle that way.  And commit message needs
> the explanation of the leak mechanism - a link to reporter is
> nice, but it doesn't explain what's going on.

Actually, nevermind the part about commit message - what you have
there is OK.  I still think that the call would be better off
in exfat_create_upcase_table(), though - less brittle that way.

