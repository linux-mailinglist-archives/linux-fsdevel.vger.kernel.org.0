Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5719330CA4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 19:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbhBBSo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 13:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhBBSm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:42:58 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC18C0613ED
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 10:42:15 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id j25so23909852oii.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 10:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGzfrsnXhgnNBXcQhxaXbM4GAEaugMss3IIAYpF95qk=;
        b=KL3fKa+7CX/VKuMHsaXqb1Kj/o/WTNYC1ZplA6ziaxDV4ag3iuqBjJaxr5+JgkAHsB
         tepUk47mcRKdWNP5rlWzlLA4kr5jYd+Z89LokH7fQ4SJUmOOBIi+43yx345F7CgB5mpm
         /Odz5mEq7ie34DkUkPBPTMMTMhqq9QCimELZ0ofKJIBAXKX9CHpRuV9YUgtZKMmYfZhX
         j2oFHgjRC3wdmkJopUkSvDHTJDP6YhdDISpc6kP02mR+uLdtwKc16mBpVe1KBevY/wDb
         f6mJaS1ioo7m/AwLJQyKmtRDTt/qRoyxIFkph3fW3sy0GKbPJ1t84xArtAl2ZjeMgRyf
         llkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGzfrsnXhgnNBXcQhxaXbM4GAEaugMss3IIAYpF95qk=;
        b=HJK9zAZQ157yREPwg9lT21VB1PNly0Pc7GtF8HZ0NBq7RU/GMouOy9QRPGUdXvzbe6
         1JPD2/McPvIytc7p12j6s2dog5KUWRIdBOsVy91fqpbth4zm2t4s2HENl15DCXYsmzkB
         efuH5TdqkziJubOH8prxZyZS52N0dlUyRL5bjvTUyvw9kWamR15JpxDNbStCrRgna0YE
         NTwzq9fuNKH3G54Ov2EiLv1nvfFzjSxsHTTrZiDctKv7LR/wF+5k7dfRXFiLcIRtkD4+
         MV0igKIWH3QeAtcV4zBp2lD86n5S6rsVp/Z/oLGLV9OQJs01GNOEX4kgrMOgARxuAlkd
         iSLA==
X-Gm-Message-State: AOAM531W1ULzaIb82Wx8ObJs+FlyA2/HkLB+feulkWdNOOxVqOg8HTcM
        iE2mLknvA28mhisAAuTu+8otlHu+jOYd0uWjZfk=
X-Google-Smtp-Source: ABdhPJzBExcuHZCpDQGPbKvNqFaaijui4YpUFeAlLdQdLloNwkfYR8gbl9evSF4KyBBaFsTu/bpITB4lVZHkwVKGgBY=
X-Received: by 2002:a54:458f:: with SMTP id z15mr3878491oib.139.1612291334759;
 Tue, 02 Feb 2021 10:42:14 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
 <20201130133652.GK11250@quack2.suse.cz> <CAE1WUT5LbFiKTAmT8V-ERH-=aGUjhOw5ZMjPMmoNWTNTspzN9w@mail.gmail.com>
 <20201130150923.GM11250@quack2.suse.cz> <20201130163613.GE4327@casper.infradead.org>
In-Reply-To: <20201130163613.GE4327@casper.infradead.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 2 Feb 2021 10:42:03 -0800
Message-ID: <CAE1WUT7mFw2_ndhW=P_Q8BRDb1rDOVixhp7sveqK=Ci6yi35fA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from
 DAX_ZERO_PAGE to XA_ZERO_ENTRY
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Apologize for taking a long time - this got swamped in a sea of other
kernel bits.

There doesn't seem to be much of a point now to switch to the XArray
zero entry for what is currently DAX_ZERO_ENTRY. However, if you want
to explore it further, a potential thought could be adapting the bits
around the XArray 257 entry. There's a large swath of available bits
that we could use between bit 3 and bit 9. If Matthew really wants to
use the XA zero entry for it, perhaps we could shift the other DAX
bits to those?

Best regards,
Amy Parker
(she/her/hers)
