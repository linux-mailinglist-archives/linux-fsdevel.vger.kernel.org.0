Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D581E6C09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406898AbgE1UGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406779AbgE1UGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 16:06:32 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D659C08C5C6;
        Thu, 28 May 2020 13:06:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeOmu-00H6ZA-KK; Thu, 28 May 2020 20:06:00 +0000
Date:   Thu, 28 May 2020 21:06:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: clean up kernel_{read,write} & friends v2
Message-ID: <20200528200600.GS23230@ZenIV.linux.org.uk>
References: <20200528054043.621510-1-hch@lst.de>
 <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <f68b7797aa73452d99508bdaf2801b3d141e7a69.camel@perches.com>
 <20200528193340.GR23230@ZenIV.linux.org.uk>
 <20200528194441.GQ17206@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528194441.GQ17206@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 12:44:41PM -0700, Matthew Wilcox wrote:
> On Thu, May 28, 2020 at 08:33:40PM +0100, Al Viro wrote:
> > On Thu, May 28, 2020 at 12:22:08PM -0700, Joe Perches wrote:
> > 
> > > Hard limits at 80 really don't work well, especially with
> > > some of the 25+ character length identifiers used today.
> > 
> > IMO any such identifier is a good reason for a warning.
> > 
> > The litmus test is actually very simple: how unpleasant would it be
> > to mention the identifiers while discussing the code over the phone?
> 
> Here's a good example of a function which should be taken out and shot:
> 
> int amdgpu_atombios_get_leakage_vddc_based_on_leakage_params(struct amdgpu_devic
> e *adev,
> ...
>         switch (frev) {
>         case 2:
>                 switch (crev) {
> ...
>                         if (profile->ucElbVDDC_Num > 0) {
>                                 for (i = 0; i < profile->ucElbVDDC_Num; i++) {
>                                         if (vddc_id_buf[i] == virtual_voltage_id) {
>                                                 for (j = 0; j < profile->ucLeakageBinNum; j++) {
>                                                         if (vbios_voltage_id <= leakage_bin[j]) {
>                                                                 *vddc = vddc_buf[j * profile->ucElbVDDC_Num + i];
> 
> I mean, I get it that AMD want to show off just how studly a monitor they
> support, but good grief ...

I must respectfully disagree.  It clearly needs to be hanged, drawn and
quartered...
