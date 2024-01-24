Return-Path: <linux-fsdevel+bounces-8828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CFF83B4E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 23:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C9E1C242EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FDB135A7C;
	Wed, 24 Jan 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psKPGUeQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7485F551
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136279; cv=none; b=czEl/jlognPn7Uzg1yZ2DtsQ+ch/670DItIAhkR3qVNpB6bjqAvzaCKPD+rU4OB+NskjchZV4q8+NVRmngDVZdmbYgYho+zr76diepLqjZkQLkWe00g1rB4cfuNxT6GNL3fCSyHHxKJ9veU0H/1fmmnCRpB6dLx9Z9lHnsk+DCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136279; c=relaxed/simple;
	bh=U2Av544vwTW56wvQLCcYoJ0EOQ3BGFuANr2TKeBwpbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8XvlMiTixEqFV/uBB4RMbTCHAkrvin1WQrPz+tfH3E7TTSHsuSDpk7xKXz4Nmm0DzDPavJflGF4ifH9NfNsm6rAbOitnaTfoJgTobrHHLs4nQyM8lSQPy1Uc7Wa5v7HhIaKVOHWeU2GRTlvZfwIs4YdQ/ym4uz5nrEbSgJD0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psKPGUeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F104C433C7;
	Wed, 24 Jan 2024 22:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706136278;
	bh=U2Av544vwTW56wvQLCcYoJ0EOQ3BGFuANr2TKeBwpbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psKPGUeQqQLa8yer5anWcBGUeQyiAe279IHZ4ucC9AhnJu/144KD0vDU3zeLYgwNw
	 BzPnb8SXB9j9UDVwQs7rl6llEi8NzLf9E7zYo6zw/QjSicvBe+6mFr6sjNDd4qT+80
	 lgN9htLBm7MhVfMNDaNEtd0sBtEIHCEYhe521hBW096/xkQ7dueFNOmlxxLNirtL5E
	 Z+jFVr4pU5RM/+iSwb6Y4HJbtMSmRe4ihLgvJJBEh4g6yCZGr9GeSn5FGA2+ZwUs93
	 bfQybMkiq5x3E3CMvUykD24ZWFoQG7Qsvx8H6Jz9QsrpEeoyx02UEOwUhlh5uqSZms
	 i/pfzqy7VSbEw==
Date: Wed, 24 Jan 2024 14:44:36 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
	tytso@mit.edu, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Subject: Re: [PATCH v4] libfs: Attempt exact-match comparison first during
 casefolded lookup
Message-ID: <20240124224436.GF1088@sol.localdomain>
References: <20240119202544.19434-1-krisman@suse.de>
 <20240119202544.19434-2-krisman@suse.de>
 <CAHk-=whW=jahYWDezh8PeudB5ozfjNpdHnek3scMAyWHT5+=Og@mail.gmail.com>
 <87mssywsqs.fsf@mailhost.krisman.be>
 <CAHk-=wh+4Msg7RKv6mvKz2LfNwK24zKFhnLUyxsrKzsXqni+Kg@mail.gmail.com>
 <87ttn2sip7.fsf_-_@mailhost.krisman.be>
 <CAHk-=wi9MDF97MGwJv_2V5QLE=f6ShgfKWUPomVKsCKYmAU9XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi9MDF97MGwJv_2V5QLE=f6ShgfKWUPomVKsCKYmAU9XQ@mail.gmail.com>

Hi Linus,

On Wed, Jan 24, 2024 at 10:42:51AM -0800, Linus Torvalds wrote:
> On Wed, 24 Jan 2024 at 10:13, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
> >
> > Just for completeness, below the version I intend to apply to
> > unicode/for-next , which is the v2, plus the comments you and Eric
> > requested. That is, unless something else comes up.
> 
> Looks ok to me.
> 
> My one comment is actually unrelated to the new code, just because the
> patch touches this code too:
> 
> >         if (len <= DNAME_INLINE_LEN - 1) {
> >                 memcpy(strbuf, str, len);
> >                 strbuf[len] = 0;
> > -               qstr.name = strbuf;
> > +               str = strbuf;
> >                 /* prevent compiler from optimizing out the temporary buffer */
> >                 barrier();
> 
> The reason for this whole mess is that allegedly utf8_strncasecmp() is
> not safe if the buffer changes under it.
> 
> At least that's what the comment says.
> 
> But honestly, I don't see it.
> 
> I think the whole "copy to a stable buffer" code can and should just
> be removed as voodoo programming.
> 
> *If* the buffer is actually changing, the name lookup code will just
> retry, so whether the return value is correct or not is irrelevant.
> 
> All that matters is that the code honors the str/len constraint, and
> not blow up - even if the data inside that str/len buffer might not be
> stable.
> 
> I don't see how the utf8 code could possibly mess up.
> 
> That code goes back to commit
> 
>   2ce3ee931a09 ("ext4: avoid utf8_strncasecmp() with unstable name")
>   fc3bb095ab02 ("f2fs: avoid utf8_strncasecmp() with unstable name")
> 
> and I think it's bogus.
> 
> Eric - the string *data* may be unsafe, but the string length passed
> to the utf8 routines is not changing any more (since it was loaded
> long ago).
> 
> And honestly, no amount of "the data may change" should possibly ever
> cause the utf8 code to then ignore the length that was passed in.
> 

Since utf8_strncasecmp() has to parse the UTF-8 sequences from the strings, and
UTF-8 sequences are variable-length and may be invalid, there are cases in which
it reads bytes from the strings multiple times.  This makes it especially
vulnerable to non-benign data races, when compared to simpler functions like
memcpy() or memcmp() that more straightforwardly do one pass through the data.

The onus should be on proving the code is safe, not proving that it's unsafe.
But for a specific example of how a data race in utf8_strncasecmp() might be
able to cause a memory safety violation, see the example I gave at
https://lore.kernel.org/linux-fsdevel/20200212063440.GL870@sol.localdomain/.

- Eric

