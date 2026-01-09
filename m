Return-Path: <linux-fsdevel+bounces-73056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C9D0AB5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 15:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B3FE3022BBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB4361665;
	Fri,  9 Jan 2026 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="M9aviRJE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6033612DE;
	Fri,  9 Jan 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969935; cv=none; b=EdCxQ0SZQ/rUYeqo49gXlY57eYanYbXJIDRhcPIwsolfSKzAehsT7Y245PWBVw9OfU7Hhuf4sHJxQtpsa4pLd9iPGcKJlxG8uG0k8HTlpkHrJHJy7D95Tcn6cy6ZRxHTEM1DXSP4RVvQc74obThu5e3FCNf7tlghloHdpr5LSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969935; c=relaxed/simple;
	bh=y0Fgp0UM3xAsp8KS+tq93rUSoJTpTYTmkf6kqfJ24j0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R7CF7jVkeusp49kXC/6r4E6PGk+TxRgeCs5PvP2XYtQxKqo+yTlhuKFQPXzMHdrxt2EJzKcd2Fz2l5CZ21wokxP3V7dplJVRmftSJCI9FgYgP986jvQb2q6OINdKTqYRI02Qh2ecifzbr21ZRFTbBL3j7O30Osn66Qi8hlw5c6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=M9aviRJE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hKja/8l4ic4ZQ5rSKgXWUJtoZhFeKvqCamWEd4W/X8w=; b=M9aviRJE8o0D8mD4XRykdKu2hF
	dXr4cj1pMcOA8agbNXYW7l6UO47DpA8oLMnUGGcHM/Xed0TyeXoGDm07hU/4UkVhl/c+Exve67bXM
	wgqufh+h3VSbEB17hBbq7EsjHAHXEh1rn68bYunODLTkVYbXBeZa5PX8b1AGImHIgxMzept5pbeOV
	s023xf2rEluZu36YPBsjSACSk8sBcniGfEOEi6Fbctmd24JTRDC40vYxlHH/0PaMrD+7ZObMSX7f7
	jhpcRMY2IMBs8cv4MSgHxnKdzuG6llgwZZm/fU5WNlnCX/53Wcou5rBR3sJC/1NFBmIo5qifWNKDw
	gnLPblvg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1veDjt-003S2S-T6; Fri, 09 Jan 2026 15:45:22 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Bernd Schubert <bschubert@ddn.com>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
	(Miklos Szeredi's message of "Fri, 9 Jan 2026 13:38:29 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
	<87zf6nov6c.fsf@wotan.olymp>
	<CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
Date: Fri, 09 Jan 2026 14:45:21 +0000
Message-ID: <87tswuq1z2.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09 2026, Miklos Szeredi wrote:

> On Fri, 9 Jan 2026 at 12:57, Luis Henriques <luis@igalia.com> wrote:
>
>> I've been trying to wrap my head around all the suggested changes, and
>> experimenting with a few options.  Since there are some major things that
>> need to be modified, I'd like to confirm that I got them right:
>>
>> 1. In the old FUSE_LOOKUP, the args->in_args[0] will continue to use the
>>    struct fuse_entry_out, which won't be changed and will continue to ha=
ve
>>    a static size.
>
> Yes.
>
>> 2. FUSE_LOOKUP_HANDLE will add a new out_arg, which will be dynamically
>>    allocated (using your suggestion: 'args->out_var_alloc').  This will =
be
>>    a new struct fuse_entry_handle_out, similar to fuse_entry_out, but
>>    replacing the struct fuse_attr by a struct fuse_statx, and adding the
>>    file handle struct.
>
> Another idea: let's simplify the interface by removing the attributes
> from the lookup reply entirely.  To get back the previous
> functionality, compound requests can be used: LOOKUP_HANDLE + STATX.

OK, interesting idea.  So, in that case we would have:

struct fuse_entry_handle_out {
	uint64_t nodeid;
	uint64_t generation;
	uint64_t entry_valid;
	struct fuse_file_handle fh;
}

I'll then need to have a look at the compound requests closely. (I had
previously skimmed through the patches that add open+getattr but didn't
gone too deep into it.)

>> 3. FUSE_LOOKUP_HANDLE will use the args->in_args[0] as an extension head=
er
>
> No, extensions go after the regular request data: headers, payload,
> extension(s).
>
> We could think about changing that for uring, where it would make
> sense to put the extensions after the regular headers, but currently
> it doesn't work that way and goes into the payload section.
>
> In any case LOOKUP_HANDLE should follow the existing practice.

Hmm... I _think_ I had it right in my head, but totally messed up my text.
English is hard.  What I meant was that args->ext_idx would be set to the
in_args[] index that would describe the extension (for the lookup
operation, that would be '3', not '0' as I mentioned above).

And then the extension header would be created similarly to what's being
done for FUSE_EXT_GROUPS, using the same helper extend_arg().  That way, I
think we would have: headers - payload - extensions.

>>    (FUSE_EXT_HANDLE).  Note that other operations (e.g. those in function
>>    create_new_entry()) will actually need to *add* an extra extension
>>    header, as extension headers are already being used there.
>
> Right.
>
>>    This extension header will use the new struct fuse_entry_handle_out.
>
> Why _out?
>
> It should just be a struct fuse_ext_header followed by a struct
> fuse_file_handle.

Yes, of course.  My English was totally messed-up.  And I meant
'fuse_file_handle', not 'fuse_entry_handle_out'.

Cheer,
--=20
Lu=C3=ADs

