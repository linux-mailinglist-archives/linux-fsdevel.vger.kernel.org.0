Return-Path: <linux-fsdevel+bounces-23443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B192C4E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 22:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA22B222D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 20:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B618D4B4;
	Tue,  9 Jul 2024 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1FMlMQ54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F818562E;
	Tue,  9 Jul 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557779; cv=none; b=ST7ThQXeLViH2DeAmVN2enzI7Cjrr1RBpbk3s58laPKlxZbGI1MIEtz+BNJaS9QcBGA7DCgJ6iX8E6btv6/FMPMl8jxBOU6XsSoUFRRQKEEyiwmp4Ks8SD/xTDxdrqLlDP9NBvS57Uw8zQjuSzIZdQs3D3AIyOlA5LpUpl1g+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557779; c=relaxed/simple;
	bh=IoWefWbaQQ+V91YTtjdF0anlb0ViXVpXd1IFsTvTs/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlO/w/4EX4NfnZRYh61WnlL35KXlPzTRIEwwrGHzvR7hMsUBpqP+BcqRia7Fv0/CLkacy2P2o6+GKN/uxL02ncWFZI3JSe/g3embxKZVCyabL3ZTyVt15HTrcWT/JmfA1r+Lj8fctOGtkIBJvXJRFDNraGr9tErbj5XbzRV+mkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1FMlMQ54; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJXxP73CTzttm;
	Tue,  9 Jul 2024 22:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720557769;
	bh=nDu9N6iZS4Lyv2hlEEUB0oUIC/M/y2uYLqX0goXo3sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1FMlMQ54mh76md4zMT3d84xYnJsItu6is9Hwa+GWCVdZd10AKJNNKloZ4aD2LRmHd
	 0IQG9slNgks/siDVdV7BybKWU9uNwJoe3tpWWxv7l0COEL+eblgknoRpVzWrJ3voPi
	 FaYe8+CubLSlDuo6ztOcihY/B53HBeoCu2doqr5w=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJXxP1tkXzT9r;
	Tue,  9 Jul 2024 22:42:49 +0200 (CEST)
Date: Tue, 9 Jul 2024 22:42:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 5/5] samples/should-exec: Add set-should-exec
Message-ID: <20240709.chait2ahKeos@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-6-mic@digikod.net>
 <968619d912ee5a57aed6c73218221ef445a0766e.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <968619d912ee5a57aed6c73218221ef445a0766e.camel@linux.ibm.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 08, 2024 at 03:40:42PM -0400, Mimi Zohar wrote:
> Hi Mickaël,
> 
> On Thu, 2024-07-04 at 21:01 +0200, Mickaël Salaün wrote:
> > Add a simple tool to set SECBIT_SHOULD_EXEC_CHECK,
> > SECBIT_SHOULD_EXEC_RESTRICT, and their lock counterparts before
> > executing a command.  This should be useful to easily test against
> > script interpreters.
> 
> The print_usage() provides the calling syntax.  Could you provide an example of
> how to use it and what to expect?

To set SECBIT_SHOULD_EXEC_CHECK, SECBIT_SHOULD_EXEC_RESTRICT, and lock
them on a new shell (session) we can use this:

./set-should-exec -crl -- bash -i

This would have no impact unless Bash, ld.so, or one of its child code
is patched to restrict execution (e.g. with execveat+AT_CHECK check).
Script interpreters and dynamic linkers need to be patch on a secure
sysetm.  Steve is enlightening Python, and we'll need more similar
changes for common user space code.  This can be an incremental work and
only enforced on some user sessions or containers for instance.

> 
> thanks,
> 
> Mimi
> 
> 

