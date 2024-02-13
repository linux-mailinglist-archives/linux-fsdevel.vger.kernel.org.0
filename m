Return-Path: <linux-fsdevel+bounces-11302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE78528C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3916286971
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75A17597;
	Tue, 13 Feb 2024 06:18:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E94134CB;
	Tue, 13 Feb 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805109; cv=none; b=aoiAsO+rn9owykw0jumXZOMjrCg83MlK70KF1+KuD/wMjq3MHE2DCjxyrnmxxjdoTAQBYgawUvO1xDXgLMxrJistHG1InpXmRupUEARDOSB4Oz8xDZD9UwQ9U/Y3wivdn88FvCHU9y6wOi8zFCoFBvRXjldmPfd2jeJawCIUhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805109; c=relaxed/simple;
	bh=Em04CzlZ7w0zgHD9OH1OvZMN1cDW1yGq0zZXVpfH8xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja0Lie6RTYCNjU7/2W6vnsUWE1NlI+SfC3JNUqvL9mM9k77Xow0oYpqzNa75UPTznhQqLiYVhQuhjZu65ct7/jAa7mqnoeN4ZULACWQrerlyh5Bpn4mbG10QSncJADs4cdHMNuWCKrlVE1jFbVq5IDPQbGAZ4r1WJAFr+5q9uo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A88B0100DECB7;
	Tue, 13 Feb 2024 07:18:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 78FE7473ECA; Tue, 13 Feb 2024 07:18:23 +0100 (CET)
Date: Tue, 13 Feb 2024 07:18:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Message-ID: <20240213061823.GB27995@wunner.de>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
 <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
 <65caa3966caa_5a7f294cf@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65caa3966caa_5a7f294cf@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 12, 2024 at 03:02:46PM -0800, Dan Williams wrote:
> However, Lukas, I think Linus is right, your DEFINE_FREE() should use
> IS_ERR_OR_NULL().

Uh... that's a negative, sir. ;)

IS_ERR_OR_NULL() results in...
* a superfluous NULL pointer check in x509_key_preparse() and
* a superfluous IS_ERR check in x509_cert_parse().

IS_ERR() results *only* in...
* a superfluous IS_ERR check in x509_cert_parse().

I can get rid of the IS_ERR() check by using assume().

I can *not* get rid of the NULL pointer check because the compiler
is compiled with -fno-delete-null-pointer-checks.  (The compiler
seems to ignore __attribute__((returns_nonnull)) due to that.)


> I.e. the problem is trying to use
> __free(x509_free_certificate) in x509_cert_parse().
> 
> > --- a/crypto/asymmetric_keys/x509_cert_parser.c
> > +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> > @@ -60,24 +60,24 @@ void x509_free_certificate(struct x509_certificate *cert)
> >   */
> >  struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
> >  {
> > -       struct x509_certificate *cert;
> > -       struct x509_parse_context *ctx;
> > +       struct x509_certificate *cert __free(x509_free_certificate);
> 
> ...make this:
> 
>     struct x509_certificate *cert __free(kfree);

That doesn't work I'm afraid.  x509_cert_parse() needs
x509_free_certificate() to be called in the error path,
not kfree().  See the existing code in current mainline:

x509_cert_parse() populates three sub-allocations in
struct x509_certificate (pub, sig, id) and two
sub-sub-allocations (pub->key, pub->params).

So I'd have to add five additional local variables which
get freed by __cleanup().  One of them (pub->key) requires
kfree_sensitive() instead of kfree(), so I'd need an extra
DEFINE_FREE() for that.

I haven't tried it but I suspect the result would look
terrible and David Howells wouldn't like it.


> ...and Mathieu, this should be IS_ERR_OR_NULL() to skip an unnecessary
> call to virtio_fs_cleanup_dax() at function exit that the compiler
> should elide.

My recommendation is to check for !IS_ERR() in the DEFINE_FREE() clause
and amend virtio_fs_cleanup_dax() with a "if (!dax_dev) return;" for
defensiveness in case someone calls it with a NULL pointer.

That's the best solution I could come up with for the x509_certificate
conversion.

Note that even with superfluous checks avoided, __cleanup() causes
gcc-12 to always generate two return paths.  It's very visible in
the generated code that all the stack unwinding code gets duplicated
in every function using __cleanup().  The existing Assembler code
of x509_key_preparse() and x509_cert_parse(), without __cleanup()
invocation, has only a single return path.

So __cleanup() bloats the code regardless of superfluous checks,
but future gcc versions might avoid that.  clang-15 generates much
more compact code (vmlinux is a couple hundred kBytes smaller),
but does weird things such as inlining x509_free_certificate()
in x509_cert_parse().

As you may have guessed, I've spent an inordinate amount of time
down that rabbit hole. ;(

Thanks,

Lukas

