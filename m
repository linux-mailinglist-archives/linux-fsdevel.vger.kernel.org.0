Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA527FDF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgJAK7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731913AbgJAK7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:59:51 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69FC0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 03:59:49 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a2so3722108ybj.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LpSM+rRHzBSMytnDHL/DL9sUB5Qjfbqr4nyejqcrB+c=;
        b=VZJh5yq3z3gLFVpd0Yf5p4+7MycS0zi4PMhMfXI3FB+7dZESFI06Q2G+uDEGQwQajK
         MfsNN50B/L7rOY9DjOng5/vpvp8v2GCVKh/0LpfWtbliSmUOoFpJPQQMQh+Vuv1gSstS
         Iccii4h0aprQbkEnbTcyUm4+Ob/SMf/Jeyh3UE1pPyDMPKykmHWRaYs7udZHgZn6HSzd
         bZ1eoYhbE6QFZWoI2JxE+d+BgrdP69bpwSfsrNr7KrENft6Qcm1j82jXOIkhJOZzH6V/
         2dNPhSaamoy+VmG9SboNfRLDJmdwEnSJ3EVAbPvhN4GHb3OyiukKc7klo6qfGwb3BI71
         wO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LpSM+rRHzBSMytnDHL/DL9sUB5Qjfbqr4nyejqcrB+c=;
        b=tMxlLKCFdM/bZ2shC3xbxJ61jN33ryrhUdrmLbOdDAYm5Y5Qm2q6MVLTa8sc27FciX
         o9JYBcx4PDYAcwAqXcZAUW9RWBUXfE4f5Rjn/I45R2QQAgLeKCRTLPNwpJ5Yxwfs3KW/
         lhnrkniQbqr2X5JIMv/6kFFMhO6MBNs6c1rX4Io5wADGd56/Gl2J1byJQM+BAAfoeZ4O
         r+BkTlS/BG/XepHUnU36a1b6OTkM85zkokGFKHSzYMrq0+cfcl+UkNDozejcGPEI8IBJ
         B80tMYT3Q4KqKsXoB4EIbNGtItZEGmI/E+0LboMTIV4uzvdlK1X4W8TeDulrdoO3RrYJ
         jMVA==
X-Gm-Message-State: AOAM532S80iua5BnBB63hkF72qlFhpJdtBPzmZLP4ZRyI8WP2RKDrYs+
        qDRn+JmBAYMB/YFv2vwJN3HWzIw0fawOOdOKMTkOAPGr0OMzNQ==
X-Google-Smtp-Source: ABdhPJx+Fm1IxjpqGApvBxBebNU8xs+4bb9LigpNro1rr8EhL6ZnhZ3epWf3lYedURNU+DD/Ny+oBRAOdujvgn/pN/0=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr9013881ybt.131.1601549988523;
 Thu, 01 Oct 2020 03:59:48 -0700 (PDT)
MIME-Version: 1.0
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Thu, 1 Oct 2020 16:29:38 +0530
Message-ID: <CANT5p=pvumVCNCLbSCaxgmfFLR-ifeQJrUETfG4ALxzfTRRxew@mail.gmail.com>
Subject: Error codes for VFS calls
To:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        samba-technical@lists.samba.org
Cc:     Steve French <smfrench@gmail.com>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi developers,

I seek your opinions about the error codes returned by the Linux
filesystem for the I/Os triggered by users. In general, each VFS
system call (open, read, write, close, stat) man page defines a
limited set of error codes returned by the call, and the meaning of
the error, in the context of that call.

But in many cases, especially in network based filesystems, this
limited set of error codes may not be sufficient to indicate the exact
problem to the user. For example, in case of SMB3, where things like
authentication or actual mount of the filesystem may be delayed to the
point of first I/O by the specific user on the mount point, having a
limited set of error codes could end up confusing the user, and not
indicate the actual error to the user.

So my questions here:
1. Should the error codes be specific to the filesystem in question,
and not just specific to the VFS system call?
2. Do we have any other mechanism of returning a custom error message
to the user (the one that tells the user about the exact problem in
more detail), other than to print this in the logs?

-- 
-Shyam
