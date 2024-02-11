Return-Path: <linux-fsdevel+bounces-11067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE2A850AD8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 19:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E694EB2110B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFFB1E4BE;
	Sun, 11 Feb 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lYYih9Nb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26BC41A86
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677084; cv=none; b=lO0N3TaO6ugEKBwhTehmC92hdMrvIHQTHYMUeEIrrz4aeGhlp1TgpnuNgGGJ+wltBnBSvlu/pE6T8k+0BJz81cj/RoYdRN+CzWV+Sw7SrZMZHMn7BRHsqPBDwLvfV3uTVDOEeUNrHJpR+M7Wj+mkLLkDiHfphS/CtltDy0StwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677084; c=relaxed/simple;
	bh=WaNLV/ayuCb2jMPzjjnxwoGspEycC25aqXbCAmy6GjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzkfmvwFKpTwdRDND/LNxF/tOXrPSofihm5J8UyYhUaWYajRzlYMlZvZbi8R1/5eppSrkvhOHfeX0Nb64Pw8rsxO/7HWzR2GiCnzxf3yU/gT9txYJabfaswOWCsPSQD8pbn5ezulFgjt8XGJXOg4OAUlfLg/BM6/5PNyDo7zjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lYYih9Nb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WRoc5Pwvt6ARNP8bMyDrSq0I7xF+I4JtJTVUE/tFc+c=; b=lYYih9NbU/6kLQFSZBdoxNb/t7
	HkKV/tZVnh5aDkDoZK4MWS1lhuAvFOIeGAt8BHQSecqg61aOkpj1qbJovdpBN8ohha67VT8yVoDlz
	Pud43bqTmf2Rqf9BvZGBVrHR+6fIgVgMWzmoN2H6xMb9aF+cma3k4A7937cqqJQyEpHA3GjJcknJ2
	TcvzhesYHo10fOlFrfuHZ9b/71QUncbNyvqtN0URhMvYfGcAxOMNc0gqIBN8QQhyu6FEEyIelPWBs
	hgQlhTmV8sk+m6L0hWnRsrTOQamg7aREf8gXchT+51MZj8JccCtATspotVxb7eM2GvKzqfQs8jtAJ
	3bvjdNmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rZEog-0067Wf-0H;
	Sun, 11 Feb 2024 18:44:38 +0000
Date: Sun, 11 Feb 2024 18:44:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] dcache: rename d_genocide()
Message-ID: <20240211184438.GH608142@ZenIV>
References: <20240210100643.2207350-1-amir73il@gmail.com>
 <20240210232718.GG608142@ZenIV>
 <CAOQ4uxhs9y27Z5VWm=5dA-VL61-YthtNK14_-7URWs3be53QFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhs9y27Z5VWm=5dA-VL61-YthtNK14_-7URWs3be53QFw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 11, 2024 at 10:00:03AM +0200, Amir Goldstein wrote:

> > whole d_genocide() thing is quite likely to disappear, turning
> > kill_litter_super() into an alias for kill_anon_super().
> 
> 2-in-1, getting rid of cruelty in the human and animal kingdom ;)

FWIW, "litter" in the above is in the sense of "trash", not "collection
of animal offspring from the same birth"...

