Return-Path: <linux-fsdevel+bounces-31812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A1299B813
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 05:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4338728324D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 03:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D29126BF9;
	Sun, 13 Oct 2024 03:04:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BEA94F;
	Sun, 13 Oct 2024 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728788660; cv=none; b=KuccJkSgWpl+sd+9IoyIr0u+Rb3iXFgqdBnQk+OT6Gs+RzvoajxAcxp8qBCycdqnwWzZ2iQi0yRCF4Up34t//fVWiwCHxbCV0sWVp7iCaWvGiX3f6WFGE1wQmPzl4A51b/gCGL1fbXvruzgps2/Org4f7THXkLStBO4hc0ujIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728788660; c=relaxed/simple;
	bh=Cu//dJwjvJhpfSidt16kc+lh4DfW37eE+mpvTKJMA60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdBJjTcjwNNU+D2x8AONAwMJ12NJ1e5mvACnJqpZyWiSV7SXXzNdFwL5LL6F2VZQKfyST+g70oE4am2M5f38TAPhNAxsvZdO/tUEaIaGH+pZiNjhtZAHOyJNRU2w4paYMkv7npwNnl6i8SJ3JeAGTu/aOA1zeeOy00fa6iMg9Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 40C2B4B5; Sat, 12 Oct 2024 22:04:16 -0500 (CDT)
Date: Sat, 12 Oct 2024 22:04:16 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v20 1/6] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20241013030416.GA1056921@mail.hallyn.com>
References: <20241011184422.977903-1-mic@digikod.net>
 <20241011184422.977903-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011184422.977903-2-mic@digikod.net>

On Fri, Oct 11, 2024 at 08:44:17PM +0200, Mickaël Salaün wrote:
> Add a new AT_CHECK flag to execveat(2) to check if a file would be

Apologies for both bikeshedding and missing earlier discussions.

But AT_CHECK sounds quite generic.  How about AT_EXEC_CHECK, or
AT_CHECK_EXEC_CREDS?  (I would suggest just AT_CHECK_CREDS since
it's for use in execveat(2), but as it's an AT_ flag, it's
probably worth being more precise).

