Return-Path: <linux-fsdevel+bounces-15182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D2887EF8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 22:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22B01C20A58
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 21:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843E1C683;
	Sun, 24 Mar 2024 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l/ezsWwo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A418638;
	Sun, 24 Mar 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314142; cv=none; b=GJ7wvqxLL9NMGQ/M7B3V34lovPtRlf9nRmM7xvZ7MjJaxMG2rSxgHWrXh70oWeY/UyXGffDXW7A9w02ywKChXjHf6z5h1nPg58SoTx36OuvJvcE82uvdhqnuxbNm4NBmgv2j8/Z3olecbGd9UQRIVz0uc+ZL9rZcNJTkRRV7T6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314142; c=relaxed/simple;
	bh=l9rxcWo8n7TOtxZSo3k1Q8wf0u6AKZ4L/iOYuCud2dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9CE25EHolmkrhGBAwOn+UJ1LCYMDQtJqLFW9Y3VXilf8zO54NO/IEUqhcSUWB9pyRyhpEDYZn82jp7Tq2zI0MN3+uJ+7r/xC0NbX8VoVrOg+vMtNo8bHbakG7Xnw5finbrIdWNF5UwZnXSPO0b2zdONjCbGzlRMxKs43KXPVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l/ezsWwo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rklqzi2NdFnhKdqckzxSh7Jo7lIkng9/OlDypgBPKVE=; b=l/ezsWwohAeL9ilP1kNIXmcFtD
	8ltIjPTDoszoZwRCbSasucKExma1aRzfrFDVjMLZ98C5r5+AuFMx7u30ko1nE5mxdWkgClu09pCaX
	/+0be2xkFy609vUxRjbfGX0+F3VaXjsTefeXpgUes2Vmr8FW0hwME+VZlyJa3PivGR08aYlRrVwOV
	JRFeCpeMjKqWAKK8pnJrafg7lcHQ5PcUDewYy9l/rFuCH+BJCO47xaTuYwqU7l9yY2kNi+XhyriGz
	sesdWau1zj51qkYlNwqjqBsisqT+rUk2zznp2tssEh6DTOmJqky8sS77V37kf+9Y2nmCEOg51xbYC
	W6Q50xOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1roUyp-00G2KE-21;
	Sun, 24 Mar 2024 21:02:11 +0000
Date: Sun, 24 Mar 2024 21:02:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Steve French <smfrench@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	CIFS <linux-cifs@vger.kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Christian Brauner <christian@brauner.io>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Subject: Re: kernel crash in mknod
Message-ID: <20240324210211.GV538574@ZenIV>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3441a4a1140944f5b418b70f557bca72@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Mar 24, 2024 at 04:50:24PM +0000, Roberto Sassu wrote:

> Also, please update the description of security_path_post_mknod() to say
> that it is not going to be called for non-regular files.

If anything, it's rather security_past_create_without_open(), and
I really wonder where does the equivalent of those actions happen
if you do close(open("foo", O_CREAT|O_RDWR, 0777)) instead of
mknod("foo", 0777, 0).  I mean, you can substitute the former
for the latter, so anything that must be done by the hook in
mknod(2) would better be covered at some point in hooks within
open(2)...  Some explanation of the relationship between those
would be nice.

