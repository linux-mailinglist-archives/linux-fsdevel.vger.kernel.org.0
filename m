Return-Path: <linux-fsdevel+bounces-70849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0087BCA8BA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57F0E305FA9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A90F2D8796;
	Fri,  5 Dec 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="txTUEIoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D682D7DD9;
	Fri,  5 Dec 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957810; cv=none; b=IbQLNhp+tX6umEw7p1PCdu09iquqVeR2PsdmV0jUqHTO5rJjb9OwbT2mIZGixImKdVObfsB0D248Z/umPuEPR7WmuixcXIMUGwGzOb6sjvkF+nRwgC3GssuTQqtkRgdmWNPxcdv38tc3hU0EcEWQUwwBls/HocqJwZE/399H5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957810; c=relaxed/simple;
	bh=jgCApnTkM7k4n6TMLMltsF4RDnzj2I11zNvWmgI18/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMSuqKQmB9wRR8M/L4h63cvN4bvybwJOi/xFXpzthodyirzPU5uKz9F1Ns8g5JJ1jB0rTtmHSGCzr4an3UZ5s7y9sWS6mZPRUKURK0ZH46SS76GlNrRAVLEQPBbdPm826OCFOpOmHhdwk5Tut4AuuO+dZ0BfZuN6oL6258BmjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=txTUEIoK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=79IAJNFJK8wa9HZ2yHoT9SQH5NbzklvqWMvm7XJcJvc=; b=txTUEIoKkv3GjwjwJSHvDGbUZV
	KSDX3maaIPvCXrOlv+rcMeUaJvvyDQcSDdM60Qxd0QUhg4OsBLssQ6fXBXmtyBsIvVmubyeZeQyeo
	dwED+euf+PNrkim2TW4PygwuwNbwmvYYT3yvinxx4NcpBWf6Z4Jr6YRX+pm/0b8+c7Uk+tZaexIG9
	RODE1eWSJeUAnl2M/3KKycyUeQvoOP18s6k23cAW5PYaOptDSs3U4BSxAQE6JfEVDxJTit1h8otC+
	RDMdGnLA3oAq+twUMQSfQZFqPFyOdfexIly2xsrEC7LJ+8jM4Soru9B9YUUwA4hyGQvK0iTpTXxUX
	g68qO5bA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vRa9G-00440g-Ch; Fri, 05 Dec 2025 18:03:18 +0000
Date: Fri, 5 Dec 2025 10:03:12 -0800
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	hch@infradead.org, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, 
	kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
Message-ID: <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
References: <fdieWSRrkaRJDRuUJYwp6EBe1NodHTz3PpVgkS662Ja0JcX3vfDbNo_bs1BM7zIkVsHmxHjeDi6jmq4sPKOCIw==@protonmail.internalid>
 <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
X-Debian-User: leitao

Hello Andreas,

On Fri, Dec 05, 2025 at 06:35:12PM +0100, Andreas Hindborg wrote:
> "Breno Leitao" <leitao@debian.org> writes:
> 
> > This series introduces a new kernel-space item registration API for configfs
> > to enable subsystems to programmatically create configfs items whose lifecycle
> > is controlled by the kernel rather than userspace.
> >
> > Currently, configfs items can only be created via userspace mkdir operations,
> > which limits their utility for kernel-driven configuration scenarios such as
> > boot parameters or hardware auto-detection.
> 
> I thought sysfs would handle this kind of scenarios?

sysfs has gaps as well, to manage user-create items.

Netconsole has two types of "targets". Those created dynamically
(CONFIG_NETCONSOLE_DYNAMIC), where user can create and remove as many
targets as it needs, and netconsole would send to it. This fits very
well in configfs.

  mkdir /sys/kernel/config/netconsole/mytarget
  .. manage the target using configfs items/files
  rmdir /sys/kernel/config/netconsole/mytarget

This is a perfect fit for configfs, and I don't see how it would work
with sysfs.

On top of that, there are netconsole targets that are coming from
cmdline (basically to cover while userspace is not initialized). These
are coming from cmdline and its life-cycle is managed by the kernel.
I.e, the kernel knows about them, and wants to expose it to the user
(which can even disable them later). This is the problem I this patch
addresses (exposing them easily).

It is kind of a mix of kernel and user-managed configuration items in
coexisting.

