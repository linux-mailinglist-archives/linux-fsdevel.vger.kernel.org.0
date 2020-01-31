Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED914E9D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 09:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgAaI4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 03:56:32 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:35848 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgAaI4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:56:31 -0500
Received: by mail-il1-f170.google.com with SMTP id b15so5534523iln.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 00:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzGDCbrMJPNJyZ/2P0UJ3WN5EUl4YjCaNeTJppuJ/oY=;
        b=UW/uv+Tu+dNdIkrYPoZ8TbMixcXIfQezUr5OjZyTaRGQVqis3GGjQ9IHVJhL3QgPUA
         MDXRDDDyOrvn8bGF9b1/jIFsZiAMneilMpvsRrOoegIhI8wmWPVFh3/t3GrXXIFsMfNP
         Hf3YqLdFGaK8CZ5zwyjiy9pcQ0buen0ObOHVSC4mI+NxiGDrFBDRfNCa8l0bn/BdNbda
         s6H1d8B+gwnnmjZQ+mYeXUvDMaMRQTKLrmcscYAO3jbSVyhqnO0xdURLj8aR4wbnqA1o
         lc/T6kTRLEhOFuDdnhlnGqICLCKZwgPkfkuM7pwUUABMUgYZED0y+MU43Eq+CBMAh7cW
         5B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzGDCbrMJPNJyZ/2P0UJ3WN5EUl4YjCaNeTJppuJ/oY=;
        b=F4itAPBo77e45t9mzrne8Bhd5zk24dM9RFktHF933lA2efF5NxaliFeTxoAxBHHlHj
         fLhusayUzA3JUB/Z1X/bBxfSSvcOLOEFurnhLlV5AsjemiDsoB3T1nTuxEHiVZsjbJy7
         tjO2m2MUp9/uWkGkzjVHU5Gc0QJqExfLyoZBxTfYvq7yawAIQSHS2+DqwkE9paKa7FLY
         PV1qpVpnK0TwsisNGBrnTZpmpemtm49Z+zRfiQ1kV9v+jOIkdHtXv3pmSamfz/N6A9BR
         R1wGQ2G+R25J3XXqbofHYAYc3oeyRi1EAbuCcU9q4p6fzk9j9uYkMDXXDIZeSsfKtEHd
         xXww==
X-Gm-Message-State: APjAAAUWoaOHOeWrWXwTfhdmPkNk7vkPOmBknVFLnso7wefUh+E2bBct
        9tDAmONVuw8BAck6QPMu2p6Qj8wJl219hhO0/q4=
X-Google-Smtp-Source: APXvYqzc7OxwTy12Ur23DhhA0v1VD+dUBJT2HR1XwwN1Qx2eYbK5ZHd3L6bWPf9vVTHoYGYpSwDVu2eIFKy3IYQdCOI=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr1808907ilg.137.1580460991217;
 Fri, 31 Jan 2020 00:56:31 -0800 (PST)
MIME-Version: 1.0
References: <20200117222212.GP8904@ZenIV.linux.org.uk> <20200117235444.GC295250@vader>
 <20200118004738.GQ8904@ZenIV.linux.org.uk> <20200118011734.GD295250@vader>
 <20200118022032.GR8904@ZenIV.linux.org.uk> <20200121230521.GA394361@vader>
 <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
 <20200122221003.GB394361@vader> <20200123034745.GI23230@ZenIV.linux.org.uk>
 <2173869.1580222138@warthog.procyon.org.uk> <20200131053150.GB17457@lst.de> <3773161.1580457868@warthog.procyon.org.uk>
In-Reply-To: <3773161.1580457868@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 31 Jan 2020 10:56:19 +0200
Message-ID: <CAOQ4uxhBiS-u2KhAUUAg6aJ+iH94YOKrtS5sT9xXyD2cJKAQ4A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
To:     David Howells <dhowells@redhat.com>
Cc:     "hch@lst.de" <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:04 AM David Howells <dhowells@redhat.com> wrote:
>
> hch@lst.de <hch@lst.de> wrote:
>
> > > I'm using direct I/O, so I'm assuming I don't need to fsync().
> >
> > Direct I/O of course requires fsync.  What makes you think different?
>
> I guess that's fair.  Even if the data makes it directly to storage, that's
> not a guarantee that the metadata does.
>

It's not only that. DIO gets data to storage *layer*, but it doesn't
tell storage *layer* to make the data durable (usually with FLUSH/FUA).

Thanks,
Amir.
