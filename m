Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D08DC5923F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 06:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfF1EAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 00:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfF1EAo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:00:44 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59CEC2070D;
        Fri, 28 Jun 2019 04:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561694443;
        bh=+VpOXo75LTdDhLhuuoxTBJKiQQ5nD94oHuo6kW9PLx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wk+ccnTKmjcm9oInzJMB+0dNNB75ucxIeut8XOCR/Y7xP6hTrcDtH7lCEaIgtzY4v
         cAcXSjofCHamgYUPbORfT/k9l+Y8il+53yCqIHfw+u84tfLmFEdAugDjO/mZXUw17Z
         rsF9Jcub8341gulC7JgVNTnhPPrCi9vEWIdrK070=
Date:   Thu, 27 Jun 2019 21:00:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mpatocka@redhat.com, gmazyland@gmail.com
Subject: Re: [RFC PATCH v5 0/1] Add dm verity root hash pkcs7 sig validation.
Message-ID: <20190628040041.GB673@sol.localdomain>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:10:47PM -0700, Jaskaran Khurana wrote:
> This patch set adds in-kernel pkcs7 signature checking for the roothash of
> the dm-verity hash tree.
> The verification is to support cases where the roothash is not secured by
> Trusted Boot, UEFI Secureboot or similar technologies.
> One of the use cases for this is for dm-verity volumes mounted after boot,
> the root hash provided during the creation of the dm-verity volume has to
> be secure and thus in-kernel validation implemented here will be used
> before we trust the root hash and allow the block device to be created.
> 
> Why we are doing validation in the Kernel?
> 
> The reason is to still be secure in cases where the attacker is able to
> compromise the user mode application in which case the user mode validation
> could not have been trusted.
> The root hash signature validation in the kernel along with existing
> dm-verity implementation gives a higher level of confidence in the
> executable code or the protected data. Before allowing the creation of
> the device mapper block device the kernel code will check that the detached
> pkcs7 signature passed to it validates the roothash and the signature is
> trusted by builtin keys set at kernel creation. The kernel should be
> secured using Verified boot, UEFI Secure Boot or similar technologies so we
> can trust it.
> 
> What about attacker mounting non dm-verity volumes to run executable
> code?
> 
> This verification can be used to have a security architecture where a LSM
> can enforce this verification for all the volumes and by doing this it can
> ensure that all executable code runs from signed and trusted dm-verity
> volumes.
> 
> Further patches will be posted that build on this and enforce this
> verification based on policy for all the volumes on the system.
> 

I don't understand your justification for this feature.

If userspace has already been pwned severely enough for the attacker to be
executing arbitrary code with CAP_SYS_ADMIN (which is what the device mapper
ioctls need), what good are restrictions on loading more binaries from disk?

Please explain your security model.

- Eric
