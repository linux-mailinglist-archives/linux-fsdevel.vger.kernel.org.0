Return-Path: <linux-fsdevel+bounces-65903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789C6C13B41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 10:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361AD1887810
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44442F619F;
	Tue, 28 Oct 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PZec/Lez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF252D6608;
	Tue, 28 Oct 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642344; cv=none; b=rbtdF3xbBZMOFUug4s1lVsk+vv3SufHf7sh0rtEp4eT7nxMynbYd+LAH9kWKCKlH3eEjz5yspQIWeWq6WYv7P3OVZIppPXEgjqIgwJa6GVqgKEBh5pk+TnW/9248cY4srkGTpCdT/kZSmiR3SMs6DxBDBE5a6TUMbRmjJK5TXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642344; c=relaxed/simple;
	bh=K7A5LEXplzJkfbatI7862m7lOmxo9hUn+BBYMb0zq7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuWjXJcGYzAFUddQlbiGFfAjF/wrNxf7YZkJQ0QJz1al1msfi/OIlqEOB+huNBfAWKv/meUmsxs1LUZFfc43vNeFBbKtmkQ/9s7WvAy3sdw0EqwtVfzVbUaR5W8BLkHuaMFgu7NDsR+cawG51p/dAugAd+FXyoIbqJVRoeux/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PZec/Lez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B71C4CEE7;
	Tue, 28 Oct 2025 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761642343;
	bh=K7A5LEXplzJkfbatI7862m7lOmxo9hUn+BBYMb0zq7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZec/LezMN2HA57TVdFf37v+PPHo/3Uoto2mBVGcWze/3hNKVlCb7PYXJVs3YNupN
	 pyndNNhHD/RoU7+mn0gX0mv53jhremANWz5BQkh4M8PvOOj2/3ifonoe4IqN0K0zi2
	 DAubPAv4WvADNnAXm09I1n3+c8kTGsA1cpQ7JrOI=
Date: Tue, 28 Oct 2025 09:47:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	linux-usb@vger.kernel.org, paul@paul-moore.com,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com, selinux@vger.kernel.org,
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 36/50] functionfs: switch to simple_remove_by_name()
Message-ID: <2025102848-freewill-atrium-ea47@gregkh>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-37-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028004614.393374-37-viro@zeniv.linux.org.uk>

On Tue, Oct 28, 2025 at 12:45:55AM +0000, Al Viro wrote:
> No need to return dentry from ffs_sb_create_file() or keep it around
> afterwards.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

