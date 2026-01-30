Return-Path: <linux-fsdevel+bounces-75971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJUGBzFFfWkaRQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:56:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BFCBF77B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4587A3019C84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 23:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5538BDA7;
	Fri, 30 Jan 2026 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AO+G3MI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790C38B999;
	Fri, 30 Jan 2026 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817360; cv=none; b=lwQ2Zp7dZdUcIY218nGkPjtXUbzS8BsNX2KRLPJa3pyrZc3XaXhcMKiK8CEYNBCnNtCgnR3+RGB08Yp7wYvGeUEFyWooABLR9m5wNjuAqkgl5TQdw8iD9IK3KchpmX2stt05Y0ksg4Jjqgr1G63uiKctJakY1BJUZEJlrYl5FwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817360; c=relaxed/simple;
	bh=Mstrtl107/xwKexWntN6sYj5esBWVe7AT7Q+cHnsYRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVrfO9mNvE3529L9QeDUN3gEi2j+0WgewnfvEHlK7CunK+ve6Z21N/AhW1BSyt+L7Wex3MulHEp2MZrQWnAjafixmx/UOrAKFY1VUOCx8N5nHqKg+6mUXKBv6IAkM+SWEIT0iZljHobCvPgtF67Vq0qJyzp+p2CuhKobckpUTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AO+G3MI/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=WunDx0fb3GW0z9IYkcolqOlpoStL9vS1z9b/3h7/9sA=; b=AO+G3MI/5/op50vRQvZ2KSjky2
	o2ePb5Zukk3sXqeoNldFFJbSdw+Qp7uPktsF7JIRKDMKPcu/acltZPsnYWSewa2lLpyc2Gx9MlnMF
	O3a5gu9xLnoZ1RZqF9iA05zLoPaHp5rsq+K1gR3L76DF8WbF9zlg8f6xM6E2G1VQAn9TaPm+Tk5Y2
	s5bwYJffBoYET1FOa8HR7vJwT9oiZweshSD1mXBXH7uapwklcxfNchd2/QTs+ZWS3FHEhaI0q2NAO
	4iOY76PwJp8GPEtE84eZvCDEagFHnDbFvVFgCapOv8se+c1FU82xSEGXvHZNGQbgXWrdNVN6O9s2V
	gVLXLJfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vlyMx-0000000ChF7-0kg1;
	Fri, 30 Jan 2026 23:57:43 +0000
Date: Fri, 30 Jan 2026 23:57:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Samuel Wu <wusamuel@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, clm@meta.com,
	android-kernel-team <android-kernel-team@google.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
Message-ID: <20260130235743.GW3183987@ZenIV>
References: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh>
 <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
 <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV>
 <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV>
 <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75971-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,linux.org.uk:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4BFCBF77B
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 02:31:54PM -0800, Samuel Wu wrote:
> On Thu, Jan 29, 2026 at 11:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > OK.  Could you take a clone of mainline repository and in there run
> > ; git fetch git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git for-wsamuel:for-wsamuel
> > then
> > ; git diff for-wsamuel e5bf5ee26663
> > to verify that for-wsamuel is identical to tree you've seen breakage on
> > ; git diff for-wsamuel-base 1544775687f0
> > to verify that for-wsamuel-base is the tree where the breakage did not reproduce
> > Then bisect from for-wsamuel-base to for-wsamuel.
> >
> > Basically, that's the offending commit split into steps; let's try to figure
> > out what causes the breakage with better resolution...
> 
> Confirming that bisect points to this patch: 09e88dc22ea2 (serialize
> ffs_ep0_open() on ffs->mutex)

So we have something that does O_NDELAY opens of ep0 *and* does not retry on
EAGAIN?

How lovely...  Could you slap
	WARN_ON(ret == -EAGAIN);
right before that
	if (ret < 0)
		return ret;
in there and see which process is doing that?  Regression is a regression, 
odd userland or not, but I would like to see what is that userland actually
trying to do there.

*grumble*

IMO at that point we have two problems - one is how to avoid a revert of the
tail of tree-in-dcache series, another is how to deal with quite real
preexisting bugs in functionfs.

Another thing to try (not as a suggestion of a fix, just an attempt to figure
out how badly would the things break): in current mainline replace that
	ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK)
in ffs_ep0_open() with
	ffs_mutex_lock(&ffs->mutex, false)
and see how badly do the things regress for userland.  Again, I'm not saying
that this is a fix - just trying to get some sense of what's the userland
is doing.

FWIW, it might make sense to try a lighter serialization in ffs_ep0_open() -
taking it there is due to the following scenario (assuming 6.18 or earlier):
ffs->state is FFS_DEACTIVATED.  ffs->opened is 0.  Two threads attempt to
open ep0.  Here's what happens prior to these patches:

static int ffs_ep0_open(struct inode *inode, struct file *file)
{
        struct ffs_data *ffs = inode->i_private;
 
        if (ffs->state == FFS_CLOSING)
                return -EBUSY;
 
        file->private_data = ffs;
        ffs_data_opened(ffs);

with
static void ffs_data_opened(struct ffs_data *ffs)
{
        refcount_inc(&ffs->ref);
        if (atomic_add_return(1, &ffs->opened) == 1 &&
                        ffs->state == FFS_DEACTIVATED) {
                ffs->state = FFS_CLOSING;
                ffs_data_reset(ffs);
        }
}

IOW, the sequence is
	if (state == FFS_CLOSING)
		return -EBUSY;
	n = atomic_add_return(1, &opened);
	if (n == 1 && state == FFS_DEACTIVATED) {
		state = FFS_CLOSING;
		ffs_data_reset();

See the race there?  If the second open() comes between the
increment of ffs->opened and setting the state to FFS_CLOSING,
it will *not* fail with EBUSY - it will proceed to return to
userland, while the first sucker is crawling through the work
in ffs_data_reset()/ffs_data_clear()/ffs_epfiles_destroy().

What's more, there's nothing to stop that second opener from
calling write() on the descriptor it got.  No exclusion there -
        ffs->state = FFS_READ_DESCRIPTORS;
        ffs->setup_state = FFS_NO_SETUP;
        ffs->flags = 0;
in ffs_data_reset() is *not* serialized against ffs_ep0_write().
Get preempted right after setting ->state and that write()
will go just fine, only to be surprised when the first thread
regains CPU and continues modifying the contents of *ffs
under whatever the second thread is doing.

That code obviously relies upon that kind of shit being prevented
by that -EBUSY logics in ep0 open() and that logics is obviously
racy as it is.  Note that other callers of ffs_data_reset() have
similar problem: ffs_func_set_alt(), for example has
        if (ffs->state == FFS_DEACTIVATED) {
                ffs->state = FFS_CLOSING;
                INIT_WORK(&ffs->reset_work, ffs_reset_work);
                schedule_work(&ffs->reset_work);
                return -ENODEV;
        }
again, with no exclusion.  Lose CPU just after seeing FFS_DEACTIVATED,
then have another thread open() the sucker and start going through
ffs_data_reset(), only to have us regain CPU and schedule this for
execution:
static void ffs_reset_work(struct work_struct *work)
{
        struct ffs_data *ffs = container_of(work,
                struct ffs_data, reset_work);
        ffs_data_reset(ffs);
}
IOW, stray ffs_data_reset() coming to surprise the opener who'd
just finished ffs_data_reset() during open(2) and proceeded to
write to the damn thing, etc.

That's obviously on the "how do we fix the preexisting bugs" side
of things, though - regression needs to be dealt with ASAP anyway.

