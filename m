Return-Path: <linux-fsdevel+bounces-79113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULfcL25spmnMPgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 06:06:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 241631E91BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 06:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED98F308012C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 05:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A72E265A;
	Tue,  3 Mar 2026 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhDeS2ql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE71A6810;
	Tue,  3 Mar 2026 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772514375; cv=none; b=t+XDyw5VXNGf33cjfr/WizHWt6k0/76y96tsC6E1VnJfvcTNMiwczNRl8N3tf64yXDp4KhnvFUFud8eMzOZ4Zij+v30zJNaB7pjGEsX5NHDfbZlU1vaeDsrfk0idIGcQ/kK3c/YfQfNrVtPgRUWhlqLFN08x2BARWKSW7N62T+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772514375; c=relaxed/simple;
	bh=whFZ1Dh9y+BdMpxKN0xrNgq+rBBG/SakjaBknyK4PUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7ZhyoOSlUMpm/Py9bdX5SITZsO5V3x0jKB1JupCPkEY3jzdsoQuw48o6DCyyTLUsbMTTew3EZg3+R0pnXMwB+F8+ruDoMSkm89TH+UBAuQfnJycnv5qnLuX1WfQ4Vz/WC5vP4JrfHW9fyekbJUNPzZxytTfBm+CQeXG9el4lKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhDeS2ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D852C116C6;
	Tue,  3 Mar 2026 05:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772514375;
	bh=whFZ1Dh9y+BdMpxKN0xrNgq+rBBG/SakjaBknyK4PUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhDeS2ql90pyBzSlx6j3qh5Lp98LGb8HlHRpcEZBC/rnX214/7swZzf7pO4N0d4oX
	 GP7ynHzGMhIryauvEjE2GUS8QcayFRClFrk7aAj/9jRPJKYlp3Tv4HuFar8NyX5gXL
	 9an+1eXXHhbseOsEi3cZR4pgOXzKT//valRz930sOr8JygjfcufJveig2MgDyTvsAQ
	 L6d5I3CIFiN2HRK21Y6zthynSj3BMw8klo6w2/sZM/oNGcgUZhhELehGLLeAWXoE5x
	 jYmDlpd6vminl3h827ecV6MYaqrSL/qEGEEk+EaV0VqTZA5OvZ8g6BdtvQ8idpcf1A
	 mZBciGz3iW7QQ==
Date: Mon, 2 Mar 2026 21:06:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Horst Birthelmer <horst@birthelmer.de>,
	Horst Birthelmer <horst@birthelmer.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
Message-ID: <20260303050614.GO13829@frogsfrogsfrogs>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box>
 <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
 <aaKiWhdfLqF0qI3w@fedora.fritz.box>
 <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
 <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com>
X-Rspamd-Queue-Id: 241631E91BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,birthelmer.de,birthelmer.com,szeredi.hu,igalia.com,vger.kernel.org,ddn.com];
	TAGGED_FROM(0.00)[bounces-79113-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ddn.com:email,birthelmer.de:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:03:26PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/2/26 19:56, Joanne Koong wrote:
> > On Sat, Feb 28, 2026 at 12:14 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> >>
> >> On Fri, Feb 27, 2026 at 10:07:20AM -0800, Joanne Koong wrote:
> >>> On Fri, Feb 27, 2026 at 9:51 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >>>>
> >>>> On Thu, Feb 26, 2026 at 11:48 PM Horst Birthelmer <horst@birthelmer.de> wrote:
> >>>>>
> >>>>> On Thu, Feb 26, 2026 at 11:12:00AM -0800, Joanne Koong wrote:
> >>>>>> On Thu, Feb 26, 2026 at 8:43 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >>>>>>>
> >>>>>>> From: Horst Birthelmer <hbirthelmer@ddn.com>
> >>>>>>>
> >>>>>>> The discussion about compound commands in fuse was
> >>>>>>> started over an argument to add a new operation that
> >>>>>>> will open a file and return its attributes in the same operation.
> >>>>>>>
> >>>>>>> Here is a demonstration of that use case with compound commands.
> >>>>>>>
> >>>>>>> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> >>>>>>> ---
> >>>>>>>  fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++--------
> >>>>>>>  fs/fuse/fuse_i.h |   4 +-
> >>>>>>>  fs/fuse/ioctl.c  |   2 +-
> >>>>>>>  3 files changed, 99 insertions(+), 18 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >>>>>>> index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..daa95a640c311fc393241bdf727e00a2bc714f35 100644
> >>>>>>> --- a/fs/fuse/file.c
> >>>>>>> +++ b/fs/fuse/file.c
> >>>>>>>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> >>>>>>> -                                unsigned int open_flags, bool isdir)
> >>>>>>> +                               struct inode *inode,
> >>>>>>
> >>>>>> As I understand it, now every open() is a opengetattr() (except for
> >>>>>> the ioctl path) but is this the desired behavior? for example if there
> >>>>>> was a previous FUSE_LOOKUP that was just done, doesn't this mean
> >>>>>> there's no getattr that's needed since the lookup refreshed the attrs?
> >>>>>> or if the server has reasonable entry_valid and attr_valid timeouts,
> >>>>>> multiple opens() of the same file would only need to send FUSE_OPEN
> >>>>>> and not the FUSE_GETATTR, no?
> >>>>>
> >>>>> So your concern is, that we send too many requests?
> >>>>> If the fuse server implwments the compound that is not the case.
> >>>>>
> >>>>
> >>>> My concern is that we're adding unnecessary overhead for every open
> >>>> when in most cases, the attributes are already uptodate. I don't think
> >>>> we can assume that the server always has attributes locally cached, so
> >>>> imo the extra getattr is nontrivial (eg might require having to
> >>>> stat()).
> >>>
> >>> Looking at where the attribute valid time gets set... it looks like
> >>> this gets stored in fi->i_time (as per
> >>> fuse_change_attributes_common()), so maybe it's better to only send
> >>> the compound open+getattr if time_before64(fi->i_time,
> >>> get_jiffies_64()) is true, otherwise only the open is needed. This
> >>> doesn't solve the O_APPEND data corruption bug seen in [1] but imo
> >>> this would be a more preferable way of doing it.

/me notes that NFS can corrupt O_APPEND writes if you're not careful to
synchronize writers at the application level...

> >> Don't take this as an objection. I'm looking for arguments, since my defense
> >> was always the line I used above (if the fuse server implements the compound,
> >> it's one call).
> > 
> > The overhead for the server to fetch the attributes may be nontrivial
> > (eg may require stat()). I really don't think we can assume the data
> > is locally cached somewhere. Why always compound the getattr to the
> > open instead of only compounding the getattr when the attributes are
> > actually invalid?
> > 
> > But maybe I'm wrong here and this is the preferable way of doing it.
> > Miklos, could you provide your input on this?
> 
> Personally I would see it as change of behavior if out of the sudden
> open is followed by getattr. In my opinion fuse server needs to make a
> decision that it wants that. Let's take my favorite sshfs example with a
> 1s latency - it be very noticeable if open would get slowed down by
> factor 2.

I wonder, since O_APPEND writes supposedly reposition the file position
to i_size before every write, can we enlarge the write reply so that the
fuse server could tell the client what i_size is supposed to be after
every write?  Or perhaps add a notification so a network filesystem
could try to keep the kernel uptodate after another node appends to a
file?

Just my unqualified opinion ;)

--D

> Thanks,
> Bernd
> 
> 
> 

