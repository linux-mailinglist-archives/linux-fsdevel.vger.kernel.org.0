Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7394A5D5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 14:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbiBANUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 08:20:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54990 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiBANUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:20:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C234C61515;
        Tue,  1 Feb 2022 13:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4A3C340EB;
        Tue,  1 Feb 2022 13:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643721654;
        bh=lQHeVBIpTtaX01UJeLFArX9Ov8vXGuvCW3au8wK6Q4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKF/eGjQu2Qg2gkqhjSKlPMFA8cIAWBXmfrLxFhxC9bBly7z2YTfr6OlNPvYeduEi
         Hk6IsWxUSM5jOMCwN4eBgS7HUzPRPnXmtds++CNcM3KSl1uNoPyNDRNBqeIZMBj1LD
         TgU+IlP+lUVrb40MKmfgQb3AGUxuS9wihRDPQSgzV6CwpxIBCrDsnskgBqAP4a+tI+
         dsrahaX8Lokpn+oEYhSH3MKYaVEh6sOPSQZv7u+6zfL+UKAzVrRlvwkCgFkazLxLSa
         DFomMarodFB0PHA2ky44yXA+P14zRmJK+yYTXPhwpARWIWpiuUVtPqfUurFU7esEBM
         HlqWQbuVuCpcw==
Date:   Tue, 1 Feb 2022 14:20:48 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <20220201132048.i2o7quedbked7t3f@wittgenstein>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220201013329.ofxhm4qingvddqhu@garbanzo>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:33:29PM -0800, Luis Chamberlain wrote:
> It would seem we keep tacking on things with ioctls for the block
> layer and filesystems. Even for new trendy things like io_uring [0].
> For a few years I have found this odd, and have slowly started
> asking folks why we don't consider alternatives like a generic
> netlink family. I've at least been told that this is desirable
> but no one has worked on it. *If* we do want this I think we just
> not only need to commit to do this, but also provide a target. LSFMM
> seems like a good place to do this.
> 
> Possible issues? Kernels without CONFIG_NET. Is that a deal breaker?
> We already have a few filesystems with their own generic netlink
> families, so not sure if this is a good argument against this.
> 
> mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family fs
> fs/cifs/netlink.c:      ret = genl_register_family(&cifs_genl_family);
> fs/dlm/netlink.c:       return genl_register_family(&family);
> fs/ksmbd/transport_ipc.c:       ret = genl_register_family(&ksmbd_genl_family);
> fs/quota/netlink.c:     if (genl_register_family(&quota_genl_family) != 0)
> mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family drivers/block
> drivers/block/nbd.c:    if (genl_register_family(&nbd_genl_family)) {
> 
> Are there other reasons to *not* use generic netlink for new features?
> For folks with experience using generic netlink on the block layer and
> their own fs, any issues or pain points observed so far?

Netlink is a giant pain to use for userspace tbh. ioctl()s aren't great
but they are way easier to add and use.
