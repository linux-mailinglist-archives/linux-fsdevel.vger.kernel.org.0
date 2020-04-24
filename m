Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353951B6AB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 03:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgDXBMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 21:12:48 -0400
Received: from mx4.wp.pl ([212.77.101.11]:12282 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgDXBMs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:12:48 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 21:12:47 EDT
Received: (wp-smtpd smtp.wp.pl 27174 invoked from network); 24 Apr 2020 03:06:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1587690367; bh=/hSyo49YRiswdFuJluGCPe5Woawb0dgbp7JtFdBsldQ=;
          h=From:To:Cc:Subject;
          b=U9LFZ78LU8I8/ljqSLrMbtvCxGfHe+pOk3U16YV4fQmf54PARXLYPHpOEiZHL0Wri
           zcjCW5AD3eTm6xma5Dk31bQ5W2zqCBngV8qd4grMOZU5+QsD+OS7eVkQzTG+7apeSq
           F8BwtwYCjo/NQko0cENvtFkiFVCwXAUXwPY0Xt7U=
Received: from unknown (HELO kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com) (kubakici@wp.pl@[163.114.132.1])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <mcgrof@kernel.org>; 24 Apr 2020 03:06:06 +0200
Date:   Thu, 23 Apr 2020 18:05:44 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        josh@joshtriplett.org, rishabhb@codeaurora.org, maco@android.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linux-wireless@vger.kernel.org,
        keescook@chromium.org, shuah@kernel.org, mfuzzey@parkeon.com,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com,
        pali.rohar@gmail.com, tiwai@suse.de, arend.vanspriel@broadcom.com,
        zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] firmware_loader: re-export fw_fallback_config into
 firmware_loader's own namespace
Message-ID: <20200423180544.60d12af0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200423203140.19510-1-mcgrof@kernel.org>
References: <20200423203140.19510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 610e19f0c656a4f8e1af37bdefd7c399
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [YUD0]                               
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Apr 2020 20:31:40 +0000 Luis R. Rodriguez wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Christoph's recent patch "firmware_loader: remove unused exports", which
> is not merged upstream yet, removed two exported symbols. One is fine to
> remove since only built-in code uses it but the other is incorrect.
> 
> If CONFIG_FW_LOADER=m so the firmware_loader is modular but
> CONFIG_FW_LOADER_USER_HELPER=y we fail at mostpost with:
> 
> ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> 
> This happens because the variable fw_fallback_config is built into the
> kernel if CONFIG_FW_LOADER_USER_HELPER=y always, so we need to grant
> access to the firmware loader module by exporting it.
> 
> Instead of just exporting it as we used to, take advantage of the new
> kernel symbol namespacing functionality, and export the symbol only to
> the firmware loader private namespace. This would prevent misuses from
> other drivers and makes it clear the goal is to keep this private to
> the firmware loader alone.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: "firmware_loader: remove unused exports"

Can't help but notice this strange form of the Fixes tag, is it
intentional?

> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
