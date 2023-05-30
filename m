Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085E717119
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 00:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjE3Wzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 18:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjE3Wzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 18:55:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB493;
        Tue, 30 May 2023 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jVMUeKDVpL/twR9uR7SJX7eIcOLgi/1Bm8xpXEwWW0c=; b=Yl8kq8eX48TbwyUeqTE4poqjHe
        zyTGAWq3wulubZ/GxIaZn3S2EEKw8XRD0dHOV/SqMfNajJ7EyVGzQcTsaA2sqw3Q4bHesYOtM42iA
        nx8Yb8Y3fPDm+xs+OVztwJn+RBOaZI0HzWQUqwW+uj11W3Kc0ysMKbtFTKU45o9H6M0wZO7zuhBWe
        0rQB5i03V1YSksuDT5WqXGEyca5KHcaLuKFZaER/6zpyaqrx3/Lu8VXrak0NPxUwZKJ5w3swv2Wl+
        uYmdCMEfdDjkdIMwjTQ5IFi0DF9HLHl3k66VyeXHA93+jnP52lkMRRZoFVR42fn292B/2JvW2Da/R
        nKmh3QMQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q48FC-00FOeL-1U;
        Tue, 30 May 2023 22:55:10 +0000
Date:   Tue, 30 May 2023 15:55:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>, ebiederm@xmission.com
Cc:     keescook@chromium.org, yzaikin@google.com, dave.hansen@intel.com,
        arnd@arndb.de, bp@alien8.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com,
        christophe.jaillet@wanadoo.fr, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, akpm@linux-foundation.org, willy@infradead.org,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sysctl: remove empty dev table
Message-ID: <ZHZ+zsOTBhvn3rfu@bombadil.infradead.org>
References: <20230526222207.982107-1-mcgrof@kernel.org>
 <CGME20230526222249eucas1p1d38aca6c5a5163bd6c48b3a56e2618b4@eucas1p1.samsung.com>
 <20230526222207.982107-2-mcgrof@kernel.org>
 <20230529200457.a42hwn7cq6np5ur4@localhost>
 <ZHYnXKb8g0zSJe7+@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHYnXKb8g0zSJe7+@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 09:42:04AM -0700, Luis Chamberlain wrote:
> On Mon, May 29, 2023 at 10:04:57PM +0200, Joel Granados wrote:
> > On Fri, May 26, 2023 at 03:22:05PM -0700, Luis Chamberlain wrote:
> > > Now that all the dev sysctls have been moved out we can remove the
> > > dev sysctl base directory. We don't need to create base directories,
> > > they are created for you as if using 'mkdir -p' with register_syctl()
> > > and register_sysctl_init(). For details refer to sysctl_mkdir_p()
> > > usage.
> > > 
> > > We save 90 bytes with this changes:
> > > 
> > > ./scripts/bloat-o-meter vmlinux.2.remove-sysctl-table vmlinux.3-remove-dev-table
> > > add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-90 (-90)
> > > Function                                     old     new   delta
> > > sysctl_init_bases                            111      85     -26
> > > dev_table                                     64       -     -64
> > > Total: Before=21257057, After=21256967, chg -0.00%
> > > 
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  kernel/sysctl.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index fa2aa8bd32b6..a7fdb828afb6 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -2344,16 +2344,11 @@ static struct ctl_table debug_table[] = {
> > >  	{ }
> > >  };
> > >  
> > > -static struct ctl_table dev_table[] = {
> > > -	{ }
> > > -};
> > > -
> > >  int __init sysctl_init_bases(void)
> > >  {
> > >  	register_sysctl_init("kernel", kern_table);
> > >  	register_sysctl_init("vm", vm_table);
> > >  	register_sysctl_init("debug", debug_table);
> > > -	register_sysctl_init("dev", dev_table);
> > >  
> > >  	return 0;
> > >  }
> > > -- 
> > > 2.39.2
> > > 
> > LGTM.
> 
> BTW, please use proper tags like Reviewed-by, and so on even if you use
> LGTM so that then if anyone uses things like b4 it can pick the tags for
> you.
> 
> > But why was dev there to begin with?
> 
> I will enhance the commit log to mention that, it was there because
> old APIs didn't create the directory for you, and now it is clear it
> is not needed. I checked ant he dev table was there since the beginning
> of sysctl.c on v2.5.0.

I've extended the commmit log with this very importance piece of
information:

The empty dev table has been in place since the v2.5.0 days because back
then ordering was essentialy. But later commit 7ec66d06362d ("sysctl:
Stop requiring explicit management of sysctl directories"), merged as of
v3.4-rc1, the entire ordering of directories was replaced by allowing
sysctl directory autogeneration. This new mechanism introduced on v3.4
allows for sysctl directories to automatically be created for sysctl
tables when they are needed and automatically removes them when no
sysctl tables use them.  That commit also added a dedicated struct
ctl_dir as a new type for these autogenerated directories.

  Luis
