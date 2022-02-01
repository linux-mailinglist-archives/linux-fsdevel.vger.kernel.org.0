Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD924A5CA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 13:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiBAM4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 07:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiBAM4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:56:22 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89456C061714;
        Tue,  1 Feb 2022 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1643720181;
        bh=0lhXHBUl87DlcDjTUNO3sOfNdzeACry/BwIu5h5Ckbo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=aWrhN73VoUu6+6bMgo4G3g7xhazdOBdC3OeJs3fu5EirieSShkxrjG3eNX0ygh+1d
         xMcURv9c47WMfQ+bS4vIZxNVRFvwtEJMziT+t6Maf9Ke6CRneJGrU38glV6E92leRt
         o7jzPPG6vf1z7Zr6UdvgtsfsB3I9ZwYjoHEBOm5A=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 96EDC1280BF8;
        Tue,  1 Feb 2022 07:56:21 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3TOI1er4DDo2; Tue,  1 Feb 2022 07:56:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1643720181;
        bh=0lhXHBUl87DlcDjTUNO3sOfNdzeACry/BwIu5h5Ckbo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=aWrhN73VoUu6+6bMgo4G3g7xhazdOBdC3OeJs3fu5EirieSShkxrjG3eNX0ygh+1d
         xMcURv9c47WMfQ+bS4vIZxNVRFvwtEJMziT+t6Maf9Ke6CRneJGrU38glV6E92leRt
         o7jzPPG6vf1z7Zr6UdvgtsfsB3I9ZwYjoHEBOm5A=
Received: from [IPv6:2601:5c4:4300:c551::c447] (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 80C2A1280BD1;
        Tue,  1 Feb 2022 07:56:20 -0500 (EST)
Message-ID: <f4f86a3e1ab20a1d7d32c7f5ae74419c8d780e82.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 01 Feb 2022 07:56:19 -0500
In-Reply-To: <20220201013329.ofxhm4qingvddqhu@garbanzo>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-01-31 at 17:33 -0800, Luis Chamberlain wrote:
> It would seem we keep tacking on things with ioctls for the block
> layer and filesystems. Even for new trendy things like io_uring [0].

And many systems besides ... we're also adding new ioctls for things
like containers.

However, could I just ask why you object to ioctls?  I agree, like any
drug, overuse leads to huge problems.  However, there are medicinal use
cases where they actually save a huge amount of pain.  So I think as
long as we're careful we can still continue using them.

What is the issue?  Just the non-introspectability of the data from the
perspective of tools like seccomp?

> For a few years I have found this odd, and have slowly started
> asking folks why we don't consider alternatives like a generic
> netlink family. I've at least been told that this is desirable
> but no one has worked on it. *If* we do want this I think we just
> not only need to commit to do this, but also provide a target. LSFMM
> seems like a good place to do this.

It's not just netlink.  We have a huge plethora of interfaces claiming
to replace the need for ioctl as a means for exchanging information
between a multiplexor and an in-kernel set of receivers.  The latest
one I noticed would be fsconfig, although that is filesystem specific
(but could be made more generic).  And, of course, configfs was
supposed to be another generic but introspectable configuration
exchange system.  We're quite good at coming up with ioctl replacement,
however when we do they don't seem to be as durable.  I think we should
really examine what we think the problem is in detail before even
starting to propose a solution.

James


