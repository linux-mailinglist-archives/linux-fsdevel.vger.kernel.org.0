Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45C14C9042
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 17:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiCAQYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 11:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiCAQYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:24:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C9C2A261;
        Tue,  1 Mar 2022 08:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nusfBlIdbXpfMm4wiT3qTZ3hNmfr5bKSb7QSujzH1UI=; b=pYThoU2wW7VOEJiQPfBHlCMahv
        zqCnqvfzxIvXyQF684ZXl6dMSupAu+LBYqBkmtKoECWsWat3LCCNhroNaovFJI+jAh/R46GwYCFWE
        6d9LsHuvKeoBKT/1NZn++wcdiXnUA7iTEq9BRV4a06D5/ZLyy0NczhhN5EIkVw38+CyOoVoRbLGPd
        1RHj8j05KfzqDIWNx2IURQr3H7kjt9QouZEHX/fEPc0dlFoE2kebsrSqpAHLPxxWn8zTtgptkk4Hs
        Mb3X23j6I2kH1xwGxTp6mPvuNCMKy5E6LxKWftW7n8rUk+AHN23zUcD7XVONvOc5vnF+SaRxLhev5
        eMVzBqkg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP5Hh-00HYWB-Bd; Tue, 01 Mar 2022 16:23:33 +0000
Date:   Tue, 1 Mar 2022 08:23:33 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <Yh5IhRKjjl6dKE41@bombadil.infradead.org>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
 <YfiXkk9HJpatFxnd@casper.infradead.org>
 <Yh1CpZWoWGPl0X5A@bombadil.infradead.org>
 <CAK8P3a137DDbMN90neSCiQ7+B2o-NpWpCZ5PAEs34PBNCdAE7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a137DDbMN90neSCiQ7+B2o-NpWpCZ5PAEs34PBNCdAE7Q@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 01, 2022 at 08:47:47AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 28, 2022 at 10:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > On Tue, Feb 01, 2022 at 02:14:42AM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 31, 2022 at 05:33:29PM -0800, Luis Chamberlain wrote:
> > > You have to get it into each architecture.  Having a single place to
> > > add a new syscall would help reduce the number of places we use
> > > multiplexor syscalls like ioctl().
> >
> > Jeesh, is such a thing really possible? I wonder if Arnd has tried or
> > what he'd think...
> 
> Definitely possible, Firoz Khan was working on this at Linaro, but he
> never finished it before he left. I still have his patches if anyone wants
> to pick it up, though it might be easier to start over at this point.
> 
> The main work that is required here is to convert
> include/uapi/asm-generic/unistd.h into the syscall.tbl format,
> with a number of architecture specific conditionals to deal with all
> the combinations of syscalls that may or may not be used on a given
> target.
> 
> After that, I would modify the scripts/syscall*.sh scripts to allow
> multiple input files, splitting the architecture specific numbers
> (under 400) from the newer numbers (over 400) that can be
> shared between all architectures in a single location.

It is not a requirement for us, but this is good to know. Thanks!

  Luis
