Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B214296E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhJKSas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbhJKSaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:30:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF4C061570;
        Mon, 11 Oct 2021 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Aknkg70Y0haNDqydeOEPitcKa2vshMcgYoElHyUiPGE=; b=nQ1AyGewS98jsQHweOzxmjMiAc
        ueot8vvsoS6SoP8E89SD/oMrkm2WVMXjX1WQXqZwkItXLuShN1CGLXmxBya+mde+3ewOQLn4FKhVu
        rOGl73sgrX+9vfr9rmyKzLnBVpQp0J9dLWG6Z4szBBfGBUYDM+Z4ARJo3iQgFAkImYeUhv0OJk4sA
        cP6lDZ67v2BFPUfGFgDrj1cFF2kBTds2MWPC97fo3yh49wgIIvLw457nCHkOLuMUIkBzinKYU/iTa
        7HtRf+88XhUZmSBpRxxA6zSQblCSsvm1P2Vy9Vq5n/uwWAbYwDZv2lm0n4WfaassDivoQnthkdbaf
        VYdg11Gg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma02S-00ANhL-Lr; Mon, 11 Oct 2021 18:28:40 +0000
Date:   Mon, 11 Oct 2021 11:28:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] zram: use ATTRIBUTE_GROUPS to fix sysfs
 deadlock module removal
Message-ID: <YWSCWInXaXEpFQGc@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-13-mcgrof@kernel.org>
 <202110051356.D8B18C4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110051356.D8B18C4@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 01:57:00PM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 09:38:05AM -0700, Luis Chamberlain wrote:
> > The ATTRIBUTE_GROUPS is typically used to avoid boiler plate
> > code which is used in many drivers. Embracing ATTRIBUTE_GROUPS was
> > long due on the zram driver, however a recent fix for sysfs allows
> > users of ATTRIBUTE_GROUPS to also associate a module to the group
> > attribute.
> 
> Does this mean that other modules using sysfs but _not_
> ATTRIBUTE_GROUPS() are still vulnerable to potential use-after-free of
> the kernfs fops?

The issue is not UAF, its the possible deadlock, but in that sense, yes.
If they don't use ATTRIBUTE_GROUPS() then there is no information being
provided to sysfs about the module owner.

  Luis
