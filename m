Return-Path: <linux-fsdevel+bounces-60315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744ECB44A3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E87016B422
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CD32F656F;
	Thu,  4 Sep 2025 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iWtduqVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891072EBDC8;
	Thu,  4 Sep 2025 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027331; cv=none; b=dBMiYQCtK8T71vJvWq6rscrO80KCW9HLf/fyEBCv2zy82X8aUzJwrY9eAYCdpOgSPyg08vaREWblLy7bKgg5v78mkJva9R1P4zKUgJeWS30fxDCMN4+SJYxhvs6c1WUb9WewGtXTrSUxaVad3bKJkiCvpi/+q1LeYa1U0+c9PL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027331; c=relaxed/simple;
	bh=wSaWmZNf1saynh+Yxr0LF+dQuis6OBX7oJn2/NuWmpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij/DwlSaXk3HyoogffhhFjZpuFDGhDA/aGt5OJia0B/Nejb0BAn5MxSbHzgD8EdDwWEK2FsVn7sFOKSKBk6a/ehEnOFNasNBQrseSDxyv6HNuKFtAmswud3y3wFeKSxx0CU8UKeKOWYZ5pa5OX1xv2z8Z3ravEvGhiX+hFQujos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iWtduqVj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IGIvEoAqtuDkRSXpRU77mzhbTzcg6YFarifGx8dUVnA=; b=iWtduqVjwtYURYzGgXJycqlxlF
	it+u/9BLmB2JKqUpvN5G8QMMTKRttfhPNSKcSEY0wLHMhg1IA87oSHQku6yq5Aq1K25006np8GJyi
	LAhrKmgjFUc4sHTWi9x5O7Fh6hKteHyux3YYrana889kN14YrjuV35CqSW8OQOZCKLLnvrwpz15rf
	9UbLdUpyackW7rxOiPnmW06fqO7Kn4vOWdHm3xkjBDJ/TaWvelbQ+SWqZSOotOhaJdmDl0K4q5lIF
	Oltkbu4PPtnrBZ/0q3/b3Dti4JY33GUvSocYKbg4rJSn3BxBG+o4laQpbhXA6++wdGzp1mjTQSGUQ
	tYDyDUSA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuJ4Q-00000009hsf-1a5t;
	Thu, 04 Sep 2025 23:08:46 +0000
Date: Fri, 5 Sep 2025 00:08:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Blake McBride <blake@mcbridemail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Colby Wes McBride <colbym84@gmail.com>
Subject: Re: [RFC] View-Based File System Model with Program-Scoped Isolation
Message-ID: <20250904230846.GR39973@ZenIV>
References: <Oa1N9bTNjTvfRX39yqCcQGpl9FJVwfDT2fTq-9NXTT8HqTIqG2Y-Gy0f7QHKcp2-TIv7NZ3bu_YexmKiGuo9FBTeCtRnVzABBVnhx5EiShk=@mcbridemail.com>
 <20250904220650.GQ39973@ZenIV>
 <DHMURiMioUDX6Ggo4Qy8C43EUoC_ltjjS52i2kgC9tl6GhjGuJXOwyf9Nb-WkI__cM0NXECZw_HdKeIUmwShKkAmP7PwqZcmGz-vBrdWYL8=@mcbridemail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHMURiMioUDX6Ggo4Qy8C43EUoC_ltjjS52i2kgC9tl6GhjGuJXOwyf9Nb-WkI__cM0NXECZw_HdKeIUmwShKkAmP7PwqZcmGz-vBrdWYL8=@mcbridemail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 04, 2025 at 10:58:12PM +0000, Blake McBride wrote:
> Off the cuff, I'd say it is an mv option. It defaults to changing all occurrences, with an option to change it only in the current view.

Huh?  mv(1) is userland; whatever it does, by definition it boils down
to a sequence of system calls.

If those "views" of yours are pasted together subtrees of the global
forest, you already can do all of that with namespaces; if they are not,
you get all kinds of interesting questions about coherency.

Which one it is?  Before anyone can discuss possible implementations
and relative merits thereof, you need to define the semantics of
what you want to implement...

And frankly, if you are thinking in terms of userland programs (file
manglers, etc.) you are going the wrong way - description will have
to be on the syscall level.

