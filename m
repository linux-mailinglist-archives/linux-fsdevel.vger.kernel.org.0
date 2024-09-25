Return-Path: <linux-fsdevel+bounces-30101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF39861F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737C61F2635C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEC5175D34;
	Wed, 25 Sep 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEMKGIXj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D915DBA3;
	Wed, 25 Sep 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276022; cv=none; b=abbaP2p3RyRbwYNSvA+fkJ+SDH+jCTHvnvkh97riAAHX9AanpTSohN2Jk0/MBdM42SgDSJacDitrxXHiVT71NJpmBN7mVP+xViZM9UG8P7xuGIWLflTLU/npF/j7PX+JxXXsmsKLFNXmDN+NoEa9BViYwxdolZv7s1Ln+H0P0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276022; c=relaxed/simple;
	bh=cjYXktHWKzkeIjMo419LCUs3QsFOhLBqwzY+eH5CvxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/H+rQeyctkHZgAIqU9jYfW730DW+jwI9O+KaC2UuU8RTx9rzv7fiicNS38xLRUcitRy0ejfShZO/q33AaQc4sEZlwFTYh9g6D65QwmxwJdWPygHdOZU/0gDF/1umnJALoJ/BMG6apcDElkn2Xoo9RwqHX1AAAgiNDyJaPieNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEMKGIXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5483DC4CEC3;
	Wed, 25 Sep 2024 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727276022;
	bh=cjYXktHWKzkeIjMo419LCUs3QsFOhLBqwzY+eH5CvxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEMKGIXj2+vaau+IqVK2a1mJ7wH9uHsN0XX3Gy9xnJLLtdJNZgCqlxtpzeL+hltTb
	 /fL/XUyBikuGWSOnZiJdEE41tpOVBp85e+7o2v2kqvDmFyUdWtORRPiRXyZ85XhJxh
	 B35OEyJziquMg0Uv7Ht4y4odsAAFprMZBc9wOw6XEemPUqD+8+fMsfC7twx0s518cd
	 nv6kQHURPHBj62TXNPHVMVrCpCHeHxkQzROQGLho+pGeY8U7Jer39mC3cPJVvzGrov
	 YWkhrqgXWrfcI8AFy+CCCHlGRqjd6hhKAzpPgSfhaZYcvWec4pTyGwJa8FdT6zlBqx
	 W8QUD+D3fqToQ==
Date: Wed, 25 Sep 2024 16:53:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <20240925-ausradieren-flugfeld-499436ac0988@brauner>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <20240925-herziehen-unerbittlich-23c5845fed06@brauner>
 <874j63an2o.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874j63an2o.fsf@email.froward.int.ebiederm.org>

On Wed, Sep 25, 2024 at 08:18:39AM GMT, Eric W. Biederman wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > Please add a:
> >
> > Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec
> >
> > to the commit where this originated from.

                  ^^^^^^^^^^^^^^^^^^^^^^^^^^

> What standing does some random github project have? 

git log --grep "Link: https://github.com/"
git log --grep "\[.\]: https://github.com/"

For any additional questions, I'm sure searching for uapi group will
bring forth the LWN articles and homepage. Otherwise the Plumber's video
stream for the associated uapi group microconference where this idea
among many other was discussed will surely help.

        Christian

