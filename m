Return-Path: <linux-fsdevel+bounces-57842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB382B25BE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEEE1C83CFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 06:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1537F253F00;
	Thu, 14 Aug 2025 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JwM7opGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC924EAAB;
	Thu, 14 Aug 2025 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153470; cv=none; b=Dkq9gHacEuZujbrM21k8Xgv7bBViSWAn5TSdRFtmI0PNChDlbmyyhsYjOA1Cn7dql+vHBB7AukgEGvVeYFcQBVXyfB9HuTOfJ1lc7mcS9cEB6UF4d6JXSMX4QhgFkesCt5ikhK7W0+cpAqd3zNKvb+nYmk7V/hqwuFUibg3FA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153470; c=relaxed/simple;
	bh=B1QTAQBoom+bZUbodaVKz7Gl/FzojVpGFCIaeqSrgsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLZ0fXjWSdak2EffuC6dYL7gBfPTEvQOHws0aOLtg8OIyBsyYE0nF56d7Fu8uhIaoRyDJq+Bs6bZCQDIYirAPY/eSoy1BK9k7+tmAw2CXpj3cI/7tTnHXD2pUUgJZ3HFW6yTZnQw2oxbRVv1tCZhfcesRRd/IbPnVh0SieK+mZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JwM7opGU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PBoXKZba7jZDXvxDCcq8JAvR5ylpCzt0nNe7Pc3u/Lw=; b=JwM7opGUcWtB53X1JsZi9MIweR
	6B1GSuOCBnnZ/BoEl30erJmH3IjFURVvUanwyoVP2ZfWCqLQC7iVSOrF9i7jRoyaFlSUytmCb/fXj
	TbBBnHX1ykMhrST8KIGlVxKLCCLU+LO13gj0KTHc3SE4ZJpQi/WFOs1SGebKuHyy7K4T4tVs0YYv2
	RGmJzTyWt7p5Wo35c3dP+/TFxBJqi52eMICCS7FG5RExIVCDI/o/iWsCwWS/EvPfQz1KDOKwvi6pW
	0+59lQHd7MP4KAVKV96V1jvJ1hbNeDm9q8wUmp/anhI6vzZRSw+BDH+qMrxb8crBzF3dRZ5pHvXI0
	tRcopWTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umRar-000000008l6-2zHC;
	Thu, 14 Aug 2025 06:37:45 +0000
Date: Thu, 14 Aug 2025 07:37:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Pavel Tikhomirov <snorcht@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev,
	Linux API <linux-api@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [RFC][CFT] selftest for permission checks in mount propagation
 changes
Message-ID: <20250814063745.GP222315@ZenIV>
References: <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
 <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <20250813185601.GJ222315@ZenIV>
 <aJzi506tGJb8CzA3@tycho.pizza>
 <20250813194145.GK222315@ZenIV>
 <CAE1zp77jmFD=rySJVLf6yU+JKZnUpjkBagC3qQHrxPotrccEbQ@mail.gmail.com>
 <20250814044239.GM222315@ZenIV>
 <20250814055142.GN222315@ZenIV>
 <20250814055702.GO222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814055702.GO222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

> void do_unshare(void)
> {
> 	FILE *f;
> 	uid_t uid = geteuid();
> 	gid_t gid = getegid();
> 	unshare(CLONE_NEWNS|CLONE_NEWUSER);
> 	f = fopen("/proc/self/uid_map", "w");
> 	fprintf(f, "0 %d 1", uid);
> 	fclose(f);
> 	f = fopen("/proc/self/setgroups", "w");
> 	fprintf(f, "deny");
> 	fclose(f);
> 	f = fopen("/proc/self/gid_map", "w");
> 	fprintf(f, "0 %d 1", gid);
> 	fclose(f);
> 	mount(NULL, "/", NULL, MS_REC|MS_PRIVATE, NULL);
> }

This obviously needs error checking - in this form it won't do
anything good without userns enabled (coredump on the first
fprintf() in there, since there won't be /proc/self/uid_map);
should probably just report CLONE_NEWUSER failure, warn about
skipped tests, fall back to unshare(CLONE_NEWNS) and skip
everything in in_child()...

