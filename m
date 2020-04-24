Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0961B6B56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 04:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDXC1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 22:27:43 -0400
Received: from mx3.wp.pl ([212.77.101.10]:11936 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgDXC1n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:27:43 -0400
Received: (wp-smtpd smtp.wp.pl 19782 invoked from network); 24 Apr 2020 04:27:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1587695259; bh=6jg83JwrUc4Qa5UTPTIUHbq5+ryy3N6k3IIDya4aHXc=;
          h=From:To:Cc:Subject;
          b=AQJIlA4V5DMc1Sd0PCeHxN/5wP0bOrRSA9HhgTR2I2nvnsDzZcHZPeniUQI7zoUPS
           ba/qPFH2u/33E9FplPJYv9De+O/3gshBsOWwDZA1R63B3/9jb4RrKws5lZ6h4ut2SO
           p/wggvjqpYo8XGw9XpmXFW2L7Jqu9sqB4X0XHTJA=
Received: from unknown (HELO kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com) (kubakici@wp.pl@[163.114.132.1])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <mcgrof@kernel.org>; 24 Apr 2020 04:27:39 +0200
Date:   Thu, 23 Apr 2020 19:27:16 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <20200423192716.2c32f5dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200424021420.GZ11244@42.do-not-panic.com>
References: <20200423203140.19510-1-mcgrof@kernel.org>
        <20200423180544.60d12af0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200424021420.GZ11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 814065103326dcc26bec12dfaf1106fd
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [wfDU]                               
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 24 Apr 2020 02:14:20 +0000 Luis Chamberlain wrote:
> On Thu, Apr 23, 2020 at 06:05:44PM -0700, Jakub Kicinski wrote:
> > On Thu, 23 Apr 2020 20:31:40 +0000 Luis R. Rodriguez wrote:  
> > > From: Luis Chamberlain <mcgrof@kernel.org>
> > > 
> > > Christoph's recent patch "firmware_loader: remove unused exports", which
> > > is not merged upstream yet, removed two exported symbols. One is fine to
> > > remove since only built-in code uses it but the other is incorrect.
> > > 
> > > If CONFIG_FW_LOADER=m so the firmware_loader is modular but
> > > CONFIG_FW_LOADER_USER_HELPER=y we fail at mostpost with:
> > > 
> > > ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> > > 
> > > This happens because the variable fw_fallback_config is built into the
> > > kernel if CONFIG_FW_LOADER_USER_HELPER=y always, so we need to grant
> > > access to the firmware loader module by exporting it.
> > > 
> > > Instead of just exporting it as we used to, take advantage of the new
> > > kernel symbol namespacing functionality, and export the symbol only to
> > > the firmware loader private namespace. This would prevent misuses from
> > > other drivers and makes it clear the goal is to keep this private to
> > > the firmware loader alone.
> > > 
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Fixes: "firmware_loader: remove unused exports"  
> > 
> > Can't help but notice this strange form of the Fixes tag, is it
> > intentional?  
> 
> Yeah, no there is no commit for the patch as the commit is ephemeral in
> a development tree not yet upstream, ie, not on Linus' tree yet. Using a
> commit here then makes no sense unless one wants to use a reference
> development tree in this case, as development trees are expected to
> rebase to move closer towards Linus' tree. When a tree rebases, the
> commit IDs change, and this is why the commit is ephemeral unless
> one uses a base tree / branch / tag.

I'd think that either the commit is rebase-able and the fix can be
squashed into it, or it's not and it has a stable commit id. 
But I guess it may get tricky around the edges..
