Return-Path: <linux-fsdevel+bounces-65934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AACDC15865
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A06A189AB22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3010D344039;
	Tue, 28 Oct 2025 15:36:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E56342CA7;
	Tue, 28 Oct 2025 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665815; cv=none; b=cyQt0lP4+5D9E8lRlukLdzANsI3rZhPcWoP84qD6+pN9usDDbr6tCf0pv9hZ2KapVpkYgsVMyVu8KB0mHs12i+8/rS8hF9z0CNBx0kJLWtuPZZzZ6xz2jO+Xf8gA2dcF3rEzwPDasAwzyc0SdWLzAwaqiAumJa5SZjQOUDHEPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665815; c=relaxed/simple;
	bh=AT1uEgiRUagYgIwDeUfnNzT7JxjLRSnmy9fGyjkeVUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBtiJOvTOsui83QVcr5k4DYcRISvXGHZzLWV8pqCMn7FZBRjH8W7ATmx+YLMWLCAT83pkOL7iRory7JCmey7hLm6c+U9D5tYl5mKX3riTgrGe08CeHylTuE9nkg5zMbUFMqUD7YJAHKGMOfbgsVmNsi6eLe9dxQp24IF2mvSKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3CD0C1404A9;
	Tue, 28 Oct 2025 15:36:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id A321A2002A;
	Tue, 28 Oct 2025 15:36:39 +0000 (UTC)
Date: Tue, 28 Oct 2025 11:37:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
 brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu,
 neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org,
 linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com,
 casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
 john.johansen@canonical.com, selinux@vger.kernel.org,
 borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 19/50] convert tracefs
Message-ID: <20251028113717.2154482d@gandalf.local.home>
In-Reply-To: <20251028004614.393374-20-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
	<20251028004614.393374-20-viro@zeniv.linux.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f6bmgxhcefm7bwohfbwepa9p8cuixubt
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A321A2002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+s7gR+r9niKNL07T0pO7ukE0upf2CD5vI=
X-HE-Tag: 1761665799-59606
X-HE-Meta: U2FsdGVkX19g0bbaz2RZh320ocW7TSQSsOT9nF8qHkd5qWlBifJ/KGtfmWtsv1mzJP9ht/c5mZRt/OtFwhvV0nurLgOmsL+MgJEwJdQoabvLgqWyyWgPOtUtslgD012XhVqixajC5WLifrc/mNIrsi899n45JcxWb92Q20WFBPjq9fbMnMjzm49UpPMD39et9NXHIuTp+8ue8LHJcfY24Tb39Ouk2tY7I25w4L+/k2xiNhHBjQibW0Hpw7CZthMHcDOEtP04RbMR+7OcgsAvcilq3cwXqyvP6wxxoNA77oyga0E0P4NCRNz/Jj7XTabrxjt2M47rWHelMrTtE3Ho2LOneBwKq0YQxYsBKf09n05la3UZdYBsNJsEB3vTPECvtqDSIEN0Vv1VQdzkGQVHiqH5dArBachPtpebDDmuJAfLPjsP32VD10VFGrg/VDlo

On Tue, 28 Oct 2025 00:45:38 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> A mix of persistent and non-persistent dentries in there.  Strictly
> speaking, no need for kill_litter_super() anyway - it pins an internal
> mount whenever a persistent dentry is created, so at fs shutdown time
> there won't be any to deal with.
> 
> However, let's make it explicit - replace d_instantiate() with
> d_make_persistent() + dput() (the latter in tracefs_end_creating(),
> where it folds with inode_unlock() into simple_done_creating())
> for dentries we want persistent and have d_make_discardable() done
> either by simple_recursive_removal() (used by tracefs_remove())
> or explicitly in eventfs_remove_events_dir().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I ran the tracing selftests and some other tests I have against this and
nothing interesting happened. I didn't run my full test suite, but it looks
sane to me.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

