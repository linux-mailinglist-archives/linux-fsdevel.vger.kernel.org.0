Return-Path: <linux-fsdevel+bounces-77239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK2rIK41kWkXggEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 03:55:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E302813DF04
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 03:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 264FB301B729
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 02:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994123EA8D;
	Sun, 15 Feb 2026 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0q7gCE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84017176ADE
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771124100; cv=none; b=ASBt93ZsSvYel014Li4MjRC03olvcT3sYteoiABIqlw/uHtMu/P/nAv1YnNu1jEOvnqGXM+jkbRJwmTijZb+eTRHuBoHDV2mQOYskYofL/WAY/tlCWJyexQuJ6MvfT8WML+66Kq5dhQzX/hi4ntYgqkpX6phWGjhzPDoADczaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771124100; c=relaxed/simple;
	bh=fK7ZZkyiK48dzgBWcXdpx7b+6/1w/6JcjME1eC3IhS8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtVQxVxi28fmdE5n9HPD3HTqoIS3wd2G7UUg0Z6qw8hvt9x2j8r2/Zur15rU/MNtwuSJj/qfS2ftBFfAY/f346mRDHWCiwIxV7vLbKBReysaUH7WSWJau5NXoeEVc7+1aV8iJzOLyd5lMHsc3vqpPQiY78rW9nNfeLO9yXj6gOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0q7gCE5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-437711e9195so1453325f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 18:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771124098; x=1771728898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2kMHVC9R3KhgqSgxiiKxf3157ayrLaqEXto3EAyfgiY=;
        b=J0q7gCE5coePngduF6fpVLNYehkVDZ8JkK0Ycoo5IwxxhwUrPNkpIyyViDjnBUXXi5
         eIP7bZZ5mg6KTgZIx4kiGcUvmFT0u8PgVhlN9wZxL4qIetEY4X/jlL7Sd0Mq9GwoJ6kV
         mNe7ooMlPQsuT+TE5EknVMUkdQXwxiLg1i1ilr4MwLIAp1fU+WXwpCHcLLKFbroO6qsg
         K6hd1zXlQ+9hcE3wdnGow9Mr00FpReINrWup0sYJn2XzSDKmG1tpXZbe3Bbi4yM2c2Gb
         FOht6CwBKzrMvp+w77gRUhS94JBeRNg6FXyiaaGImGiwhb5+oHRUayMdOpRdQ2Z4b69Y
         0eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771124098; x=1771728898;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kMHVC9R3KhgqSgxiiKxf3157ayrLaqEXto3EAyfgiY=;
        b=BPqGnE2Xz/0a/nLvgWkMnxMVZPOFn0YQioiIsXjIPd8tH+0zgAn/0ngwFs8XyorTsk
         KqPMZbVyQlUy7NrsYMX6WbO7aImW1zoyKhZSnqyIalLuOBUvdSgIMDwA9Z2rKYxBgNx9
         uU2y/uYi4yP+JSOnsFlNkgrYF6N+bEVJaOzF2aQ8n6EV3r94CnYtW2+hmwi+tHFeNwGh
         9s/2a9OOkLJQpQjD4prdDRjNDloqT8AQNoxWDtTQmnrnopiUlGIqdJuXlvUO0weQ3Mr8
         u3mo0h/Er6qKvmyZOhMthj7q73wU0kO0exXutzENSjpIwWrptwNyvpC2PRrwChTqiweQ
         qjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9+Yo4fupZDIwnyJdTx0sUr+1PTSbXLCL0ZNVeB0AwZZg3NBGVyl3cOe4rO1rcPAbIyoFgvAT1mTwiNeD3@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVcJwoSk4aCywlncGhUZC6Tv8hljaW5OZGuQ3HteY2W6mp/qn
	rKMoJg8fUuMCq1im8DbcQiRUvTsGR+Vz6l8But8yx62vYf7qEVcLD8LG
X-Gm-Gg: AZuq6aKigLjunl4Ke+ThT7FkD6NUwKanoBZWsdP0ioGik/4idaAXMcddnDM8c5VBCla
	hMwMXc5c4qc56I1OaSClR8IRhxRl6YXHz7DbSFlBFnuc3lHfZFeZ8LnUcrSx50oJ7iaOCa5rZaI
	G1kDftKBUUqzJJ+7KZo/Io3YrYXzRCeQ3v31uwaoLURPkN2MTAc35PoRTWf+LSpSJ9nv4fBIIlD
	fjuUg54nzzbxnnzq/Mgqjrxo7MvCsbJizlkqlNoMY9kbKkg324UAp12aOhWSZ2EVALME9LZ96rW
	ZmNqhz11122BWuJ4hvpD2HCWLuwMH3L1NeqqEKDezaSeae+17kW3sGm3lWkEm3+NQQTrn2RBxtr
	uLEH3PwFnjlG1M66DGsHELNOmem4lNCwTg2YuCR8cqH3Bu2RnzT8gCPoMfXWfK2NZ0hVtDYI4vt
	WgLgeJVxkqUx0OiTGQ2lJHPS6AcwFow0pLZGz/AluYZCTB2a2kdaC9aA==
X-Received: by 2002:a05:6000:1842:b0:437:6d8c:c08a with SMTP id ffacd0b85a97d-43796af9dc8mr13792216f8f.45.1771124097834;
        Sat, 14 Feb 2026 18:54:57 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-125.ip49.fastwebnet.it. [93.34.90.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac92sm16579708f8f.1.2026.02.14.18.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 18:54:57 -0800 (PST)
Message-ID: <69913581.5d0a0220.340e.3d3e@mx.google.com>
X-Google-Original-Message-ID: <aZE1focZ0vshBHIV@Ansuel-XPS.>
Date: Sun, 15 Feb 2026 03:54:54 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: correctly handle space in path on cpio
 list generation
References: <20260209153800.28228-1-ansuelsmth@gmail.com>
 <20260210223431.6bf63673.ddiss@suse.de>
 <698b6ced.050a0220.9e34a.3e08@mx.google.com>
 <20260211113308.4c5b0b82.ddiss@suse.de>
 <698bd439.050a0220.38f6b4.a251@mx.google.com>
 <20260211134025.57a4d249.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211134025.57a4d249.ddiss@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77239-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E302813DF04
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 01:40:25PM +1100, David Disseldorp wrote:
> On Wed, 11 Feb 2026 01:58:27 +0100, Christian Marangi wrote:
> 
> > > What happens when someone wants support for filenames containing spaces
> > > and quotes?
> > >   
> > 
> > I mean... it's a less common case where filename start to have almost invalid
> > char but yes it's a valid point.
> > 
> > > > I'm open to both solution. Lets just agree on one of the 2.  
> > > 
> > > I don't think any of the options will be particularly simple, but
> > > nul-byte delimited field support might be the most straightforward.
> > >   
> > 
> > Yes that was the initial idea but was quickly scrapped as major work is needed
> > in the .c tool to handle NULL separated entry.
> > 
> > Can you by chance point to me how the GNU tool work with --null ?
> > 
> > 
> > They also create a cpio_list file with entry NULL separated?
> 
> E.g. dracut uses the GNU cpio --null alongside find -print0:
> 
>   cd "$initdir"
>   find . -print0 | sort -z \
>       | cpio ${CPIO_REPRODUCIBLE:+--reproducible} --null ${cpio_owner:+-R "$cpio_owner"} -H newc -o --quiet \
>       | $compress >> "${DRACUT_TMPDIR}/initramfs.img"

Ok I finished developing this and while testing it I had an interesting idea...
What if the delimiter is auto detected by checking the very next char after the
file type?

This way we can support a number of different format without having to update
any file...

The .c file had to be reworked for the tokenizer conversion so this
autodetection feature is litterally disabling the format validation of the
string and make the delimiter dynamic for the string based on the next char


For example in one file we can have these kind of thing without having to
support any additional arg.

nod /dev/tty0 660 0 0 c 4 0
nod /dev/tty1 660 0 0 c 4 1
nod /dev/random 666 0 0 c 1 8
nod /dev/urandom 666 0 0 c 1 9
# dir /dev/pts 755 0 0

nod|/dev/pts|755|0|0|c|0|9

dir\0/bin\755\01000\01000

(the \0 are NULL char, it's here to display in the actual file they are zero
char)

Wonder if this might be interesting or I should just stick to the current idea
of adding a -0 option and enforce the NULL delimiter.



-- 
	Ansuel

