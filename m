Return-Path: <linux-fsdevel+bounces-45028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D5EA703F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C447A6262
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290A25BAD6;
	Tue, 25 Mar 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcyWc/R6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16641197A7A;
	Tue, 25 Mar 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913605; cv=none; b=DIc1rdMX/4Aas1pVKqxb+k+0nIPj2trr+T+uT/leo6qTQaoKrNaPEgndWjy4X29ei7b34wh3CQMlyGeS/DcfH35GQmccBy9Tsw9wLjIMkdo+b0qaNTx/VDDysCnRZdldzVMPEZyD4vuVtF+gfoq5WsYlTheRidjMLBz+lHhc+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913605; c=relaxed/simple;
	bh=NOu2dEjZjNyRR7ev3N8tyYgYXm16NuUTpuYOhgNGviE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH1AgdRJ7b3rIMb3Qb8Vdo8y69575aknHBFWVoZF7YI2uH0RORJCDTYfRNwQb992upwG5UsT7izTykJve5OKW/QhDOh7k5EvzaiEXl6X2nOgOClnXEROCepnecx4x+wodRqPuUsg0xnFkqF8q2FYlhCdF53yF8khAuCujOgOxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcyWc/R6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87F8C4CEE4;
	Tue, 25 Mar 2025 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913604;
	bh=NOu2dEjZjNyRR7ev3N8tyYgYXm16NuUTpuYOhgNGviE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcyWc/R6Aj3Gt0V/40m326ZlGgq1U+AWyRnu1EK3Oi9qll3sgjc32xj/e472oLNoe
	 6kYLjmfPCwj58SvMirqbaycnyIRuetgxcM1jBHQ/ZvPJ50r7J67VVEbj4AltmgFr3F
	 5KEVknu7q3GK4B2ZIVbkyoTEd7kUsPHxMcjgi2ACWbj0SFH1Bdo6v5EJR5egKS0IFa
	 UWuArncw3ptQS3DuAMVRtE83DlLPKMLU3UiiSQdRzl5xEBnfDJ3DKDfr8rRTI22BNK
	 kXCsAVzgs3ilAfT1BpmeLDHGZq5A3qPgDEOSvthK/5wOR7iqeGpXoO5e6AcqOLiFr5
	 7nO7IJLsejlPg==
Date: Tue, 25 Mar 2025 15:40:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, asml.silence@gmail.com, hch@infradead.org, axboe@kernel.dk, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "David S. Miller" <davem@davemloft.net>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs/for-next 2/3] splice: Move splice_to_socket to
 net/socket.c
Message-ID: <20250325-umkurven-abtauchen-47ab46d2d7f7@brauner>
References: <20250322203558.206411-1-jdamato@fastly.com>
 <20250322203558.206411-3-jdamato@fastly.com>
 <20250324141526.5b5b0773@kernel.org>
 <Z-HiYx5C_HMWwO14@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-HiYx5C_HMWwO14@LQ3V64L9R2>

On Mon, Mar 24, 2025 at 03:53:23PM -0700, Joe Damato wrote:
> On Mon, Mar 24, 2025 at 02:15:26PM -0700, Jakub Kicinski wrote:
> > On Sat, 22 Mar 2025 20:35:45 +0000 Joe Damato wrote:
> > > Eliminate the #ifdef CONFIG_NET from fs/splice.c and move the
> > > splice_to_socket helper to net/socket.c, where the other splice socket
> > > helpers live (like sock_splice_read and sock_splice_eof).
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > 
> > Matter of preference, to some extent, but FWIW:
> > 
> > Acked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Thanks for the ACK.
> 
> It looks like Jens thinks maybe the code should stay where it is and
> given that it might be more "splice related" than networking, it may

Uhm, it should stay in fs/ especially since it's closely tied to
pipe_lock().

