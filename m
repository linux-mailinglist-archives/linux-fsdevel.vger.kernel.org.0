Return-Path: <linux-fsdevel+bounces-78299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKr6FIT6nWmeSwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:22:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C3818BFE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EFB5315BDB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33943ACA66;
	Tue, 24 Feb 2026 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnG6yk4i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B528643A;
	Tue, 24 Feb 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960666; cv=none; b=qgtQeMGkzWBqji3q29/wUB+101W1WAMTCqPHjRszUY/lY2m0obBvcv7SLIK9cq5oGTl1rOZ+np5aAFtnnu1f2K+XHsZGaR1GgbumBK0nuQGSXjL7U0V2d3YUcxoYNeuWmY7zm7ZIy29PfaVRnk3YzSaS0pPPLKwwqn5JE/08Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960666; c=relaxed/simple;
	bh=yZo3aV05MfTY9I1xb/ZlO4ur0zlxYGJ0xQv68/z5aQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy2q6H5lbcjk+Dnal1BmcAhAzXXchnKWy66gP4RBsOc6SY6wBnF2st7h0JoOWWS9gzuLqnpguNm46YOkxe2SfyrmWnCfIlDPahbz4GgfcYpaIl3Ga6OPe37TU6TmJGGgBhPWOYWHvQeGq2nw2L1c3xG1OECNpDGEMbHAAsMxoRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnG6yk4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FFEC116D0;
	Tue, 24 Feb 2026 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771960665;
	bh=yZo3aV05MfTY9I1xb/ZlO4ur0zlxYGJ0xQv68/z5aQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnG6yk4iLPe4fN3FpI287hQfCMNe5M5oK7n99UbvOzMZimXZ5TOABXRHeb/svAzJC
	 AVOnHuXIChrXUgH8t9nhCDguZFHz/1+jkrQt54iWhcCDrc8+HOP/M/s9VxDitpuQeI
	 VqSwNAnjcVeWcvG1eNXOgKmZo39KZQ1FC8mi6xX1Z9EUhCt86Mbb87xXI5V0ucKwSW
	 Mr8ZAxtgO0ap/vCSeJMWtGVL1kd4fUX8G6xMe57ahxIqjc1hpWVAT8rIQp5KA0dcM3
	 ltkf36h0CAvABv6agxpHVnpXtSZvTIqbu1zCZHfY8/M4pydheqyr5q/sK4DQ497WjV
	 10DpbLBepnadA==
Date: Tue, 24 Feb 2026 11:17:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: miklos@szeredi.hu, stable@vger.kernel.org, joannelkoong@gmail.com,
	bpf@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
Message-ID: <20260224191745.GB13829@frogsfrogsfrogs>
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
 <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
 <aZ1iT-KBp8Vt002k@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ1iT-KBp8Vt002k@fedora.fritz.box>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,ddn.com:server fail];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78299-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,vger.kernel.org,gmail.com,bsbernd.com,gompa.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09C3818BFE2
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 09:36:38AM +0100, Horst Birthelmer wrote:
> On Mon, Feb 23, 2026 at 03:06:50PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > gcc 15 complains about an uninitialized variable val that is passed by
> > reference into fuse_conn_limit_write:
> > 
> >  control.c: In function ‘fuse_conn_congestion_threshold_write’:
> >  include/asm-generic/rwonce.h:55:37: warning: ‘val’ may be used uninitialized [-Wmaybe-uninitialized]
> >     55 |         *(volatile typeof(x) *)&(x) = (val);                            \
> >        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> >  include/asm-generic/rwonce.h:61:9: note: in expansion of macro ‘__WRITE_ONCE’
> >     61 |         __WRITE_ONCE(x, val);                                           \
> >        |         ^~~~~~~~~~~~
> >  control.c:178:9: note: in expansion of macro ‘WRITE_ONCE’
> >    178 |         WRITE_ONCE(fc->congestion_threshold, val);
> >        |         ^~~~~~~~~~
> >  control.c:166:18: note: ‘val’ was declared here
> >    166 |         unsigned val;
> >        |                  ^~~
> > 
> > Unfortunately there's enough macro spew involved in kstrtoul_from_user
> > that I think gcc gives up on its analysis and sprays the above warning.
> > AFAICT it's not actually a bug, but we could just zero-initialize the
> > variable to enable using -Wmaybe-uninitialized to find real problems.
> > 
> > Previously we would use some weird uninitialized_var annotation to quiet
> > down the warnings, so clearly this code has been like this for quite
> > some time.
> > 
> > Cc: <stable@vger.kernel.org> # v5.9
> > Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/control.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > 
> > diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> > index 140bd5730d9984..073c2d8e4dfc7c 100644
> > --- a/fs/fuse/control.c
> > +++ b/fs/fuse/control.c
> > @@ -121,7 +121,7 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
> >  					      const char __user *buf,
> >  					      size_t count, loff_t *ppos)
> >  {
> > -	unsigned val;
> > +	unsigned val = 0;
> >  	ssize_t ret;
> >  
> >  	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
> > @@ -163,7 +163,7 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
> >  						    const char __user *buf,
> >  						    size_t count, loff_t *ppos)
> >  {
> > -	unsigned val;
> > +	unsigned val = 0;
> >  	struct fuse_conn *fc;
> >  	ssize_t ret;
> >  
> > 
> > 
> 
> This looks good to me. Trivial fix for an annoying problem.
> Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>

Thanks for the review!

--D

