Return-Path: <linux-fsdevel+bounces-33210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145AA9B585B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 01:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454091C228B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1E7489;
	Wed, 30 Oct 2024 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aMBFD8n0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AEBA49;
	Wed, 30 Oct 2024 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247121; cv=none; b=TVcaG2Tx70LNWBtdI1zZrYGU3rciGN1UsrSeoVxOFUzslB+hkiK2WP7wUkvTdUl9DklfRMABcSg9CYl0FfL8MKqHagGZd9v3gJjt5zMAI6t4iAOrSBV/Ub3QLLo7cdVx6OGQwmGgEIgjDYtTe0beqiVUrNF/NMlBKEzf5mtAVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247121; c=relaxed/simple;
	bh=6fqx+fBwCUhdf5wBO/O6QYAWI8L0keIgHo89A0XY100=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqRWd2cF0EmxhvA5Nsd6RrfuSZWNnfPxK/lpIztJiYfWKe9g3UfRevlLMfraDh/OGI4i881JIFSEhW5VrkKSDy9F5SNKiqwvMGE8p75nLyb8JNK5Nb30kDfIeEcdD8qGbj9j++5fgIbNSRj95lhgj9QX4o1E71wZXp7YgBZAxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aMBFD8n0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=50kDheFJoL1v0G60YGTJ0lxn66NL5Mr1869/rHwfCVk=; b=aMBFD8n01kNyPz7DZ9s012H2PD
	oaFEomS/LxechLafW7XfCF47zICZa030u/I9AeFZSFbxRG+n+n1ZZeHK0LysiS0rKyyLLRhx5wqTa
	z5ATZxLrtRB8RgFzhTbRrMc6Kow/5J5yAh/d+O4vDnpxTLROsh5RsJmnF1wW8vPggkCohdl/6kBsp
	KbYU44UZ7NcPk1h13vN1G6X2TFlatEC4mncjy+U8JVVEkmdpiUvOeEI8j2MWV1b7U1zJbkgEZO2+e
	3WEsiZfeALvZtCbITCE7zuPnFu6n0UnKhME2qtFb2NQqYSuqiQFHfsc6WYv8e+e1LKVU/c303OrP9
	5NM9WbyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t5wJX-00000009HKD-2eAI;
	Wed, 30 Oct 2024 00:11:55 +0000
Date: Wed, 30 Oct 2024 00:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
	josef@toxicpanda.com
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Message-ID: <20241030001155.GF1350452@ZenIV>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029231244.2834368-3-song@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 29, 2024 at 04:12:41PM -0700, Song Liu wrote:
> +		if (strstr(file_name->name, item->prefix) == (char *)file_name->name)

	Huh?  "Find the first substring (if any) equal to item->prefix and
then check if that happens to be in the very beginning"???

	And you are placing that into the place where it's most likely to cause
the maximal braindamage and spread all over the tree.  Wonderful ;-/

	Where does that "idiom" come from, anyway?  Java?  Not the first time
I see that kind of garbage; typecast is an unusual twist, though...

