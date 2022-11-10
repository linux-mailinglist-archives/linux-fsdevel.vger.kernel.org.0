Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B3624929
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKJSPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 13:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiKJSPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:15:50 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D743D4731B;
        Thu, 10 Nov 2022 10:15:48 -0800 (PST)
Received: from letrec.thunk.org ([12.139.153.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2AAIFdvI015314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 13:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1668104142; bh=ubhDJ0hNK+jqpKfYrnAyE4FAIXC9zmOHLMHL5eh6JY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fgR7SKMvpGIIuDf380q+kF2DNNC9MZP/1VsvT/uGvp4wfDv/bCj+Ux7tLx3wf+Da2
         RVpn2AmFV/qUe9OyU+hk/snuKAsd9BccwxCSbN0IA/kkPGt1OlhdglmpXxnF+6nbVF
         u6zBelcsfCD4MDtxRMSjT1+hVxwIqVv9hsykhLSEmzeGDV7rE4M7VqBnY6HBXdXSvn
         jHG7Mwd6rJ4YOhULQbbNWiEqEtyqglHM9o+oTBAwNvIgQbYNMScI1Y1HCZcd1BLREq
         aZWbrw0QSy1j+i0Ok9uoP95DxQNGE/s0k7WWndJPherdadwhARAjPOJ883BvjM0/O3
         4JhCo6zj0OZLg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id D00318C0252; Thu, 10 Nov 2022 13:15:38 -0500 (EST)
Date:   Thu, 10 Nov 2022 13:15:38 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Niels de Vos <ndevos@redhat.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>
Subject: Re: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Message-ID: <Y20/ynxvIqOyRbxK@mit.edu>
References: <20221110141225.2308856-1-ndevos@redhat.com>
 <Y20a/akbY8Wcy3qg@mit.edu>
 <Y20rDl45vSmdEo3N@ndevos-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20rDl45vSmdEo3N@ndevos-x1>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:47:10PM +0100, Niels de Vos wrote:
> And, there actually are options like CONFIG_EXT4_FS_POSIX_ACL and
> CONFIG_EXT4_FS_SECURITY. Because these exist already, I did not expect
> too much concerns with proposing a CONFIG_EXT4_FS_ENCRYPTION...

Actually, I was thinking of getting rid of them, as we've already
gotten rid of EXT4_FS_POSIX_ACL....

> Thanks for adding some history about this. I understand that extra
> options are needed while creating/tuning the filesystems. Preventing
> users from setting the right options in a filesystem is not easy, even
> if tools from a distribution do not offer setting the options. Disks can
> be portable, or network-attached, and have options enabled that an other
> distributions kernel does not (want to) support.

Sure, but as I said, there are **tons** of file system features that
have not and/or still are not supported for distros, but for which we
don't have kernel config knobs.  This includes ext4's bigalloc and
inline data, btrfs's dedup and reflink support, xfs online fsck, etc.,
etc., etc.  Heck, ext4 is only supported up to a certain size by Red
Hat, and we don't have a Kernel config so that the kernel will
absolutely refuse to mount an ext4 file system larger than The
Officially Supported RHEL Capacity Limit for Ext4.  So what makes
fscrypt different from all of these other unsupported file system
features?

There are plenty of times when I've had to explain to customers why,
sure they could build their own kernels for RHEL 4 (back in the day
when I worked for Big Blue and had to talk to lots of enterprise
customers), but if they did, Red Hat support would refuse to give them
the time of day if they called asking for help.  We didn't set up use
digitally signed kernels with trusted boot so that a IBM server would
refuse to boot anything other than An Officially Signed RHEL
Kernel...

What makes fscrypt different that we think we need to enforce this
using technical means, other than a simple, "this feature is not
supported"?

						- Ted
