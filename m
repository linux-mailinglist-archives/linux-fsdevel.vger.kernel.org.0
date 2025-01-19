Return-Path: <linux-fsdevel+bounces-39600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF850A1605C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 06:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0316B7A3182
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 05:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2A4964E;
	Sun, 19 Jan 2025 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d5MkOQAq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCBF2B9A5
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737265200; cv=none; b=LXQFxBZj8GoYVGry/1dOAP1QJSQ56sLTZvsGAEmwalDaGZltyjwaWd5EkOzjw3kcymaaQQUVRcytNgBMF8o7tR0swYZ7gK8xv2zxcAfWXhR3oH6/D61GuMgi4MdKVkxzAxnr/CKPKSMHC5EIOUX89AXRqovOOyiJJ3oxuSZvjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737265200; c=relaxed/simple;
	bh=yeSv7A0RzVaNXUU5lrF5wmep8AjxlvTGl2rYY1N+tMc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kgt6j88YYRPwSx06V2pOpRPvC9CjZqaze0y1VlO5ImP7Dgyv88KIQCBvuE5wUHVExuVZF6m591gqQtLm0sYYiSKevODJzJ4qQ1sXcS6s/1KKH0iJS1er/C+eWvXbs0awhXlleMv3ito9TCv+NU0ZyKOOg8RX1S34Z321OnsLYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d5MkOQAq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8KXq+2Wj9Eo48uZou9AkuO4xinFPXVYDFFPF56i6S6Q=; b=d5MkOQAqNpcv/rqaINrwYEn/gR
	uSfJBgI/CFUrLiaY3Fzc+eQTRZB7ReAhhEYeWFACC4KqHHirwKC1F9JLA9Vps1gZNpKps7ciJe+pM
	Qpfjt1BWqc3S53STM6VAhYAKuLv2T/NJbH3kht2ZiNvO1syN5fpil/Dq054bDFPLmxsvFNfj1iZ/L
	sphGHXu2NIahQio0oPzcGJrTe2fIsBx/Ex2JY/zGDmYnzJEZjzIo9nNUwx/i2szf2bF2PZCOjNYSl
	1MYkd6hpNwuS+0Eajleaew5bekPJ+5R0pQpG2QUXot9aDnLM5zqZBPyOFgnffA6yk8ocl5sAuFiDi
	5SjPh1lw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tZO2O-00000004jHd-05ZA
	for linux-fsdevel@vger.kernel.org;
	Sun, 19 Jan 2025 05:39:56 +0000
Date: Sun, 19 Jan 2025 05:39:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [RFC] EOPENSTALE handling in path_openat()
Message-ID: <20250119053956.GX1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	We have something very odd in the end of path_openat():

        if (error == -EOPENSTALE) {
		if (flags & LOOKUP_RCU)
			error = -ECHILD;
		else   
			error = -ESTALE;
	}

Note that *nothing* that may return EOPENSTALE is ever called in
RCU mode, pretty much by definition - we must have done something
blocking to have gotten that and in RCU mode that's not going to
happen.

This check does not look for RCU mode, though - it checks whether
we'd *started* in RCU mode, ignoring any successful unlazy that
might have landed us in non-RCU mode.  So this ECHILD is not
a dead code.

It really looks like it ought to have been - there's nothing
a retry in non-RCU mode would have solved; the checks on ->d_seq
should've guaranteed that there had been possible timings for
just that tree traversal in non-RCU mode, hitting exact same
dentries.  If they hadn't, we have a much worse problem there...

Miklos, could you recall what was the original intent of that?
Do we want to keep that logics there, or should it just turn into
"map -ENOPENSTALE to -ESTALE??

