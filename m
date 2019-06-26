Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623965713C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 21:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFZTEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 15:04:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36610 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZTEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:04:06 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so5794594ioh.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VKtnnmbioE9YmFDHEryqIRwRw2jsuw3ZA4a/XVWKC7U=;
        b=rC1NdcfMmIl+ogqqColFqMiS+l8nUGfYcvlXAa13Xy1r4kJPveyb2aUPFbgcXHrIHe
         fnlOTQfkbXvAsYAfIUKlHRzCrFh9QB5mslctXL8fCRRSQt52UBOt8RX9BDL0sKbbr/XY
         9rh2ase5SwdnMFAwTn6TYFq90CtxDuflOhsEdmTg/FSgNuvlmh40wfQ963+NVzlBftsw
         VFJH7u3vnWQMaNLwwhay4HuwAIOFxZhjjsTWq2/feAXFQGPaEH+iVbMhkfRxkaKK2mHD
         wshngShWugmfJsRZ/aC0SrJwLoqk6lBCwe3lcPQcZfXUiGraqXUq/WoVm2nVuaJHmeQR
         xusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VKtnnmbioE9YmFDHEryqIRwRw2jsuw3ZA4a/XVWKC7U=;
        b=CpvBx+HN+n0opabOO8eehLZwhNTEwRmcJC+YNHF0S4ffg/9HJr2I8C7+TMto4LaWCX
         90zsVtuPuejc3aKhGkLkCcndCT/nnVQypW6jJe9I8hjbQNu9u/W8IehjzUrB52cixP/Q
         Xi9hOvPASg7pZKTggeVO6fn0rPuzYRJZZiCy0KQ7K+l949J5gxaXE6q/RNoVFmQ4m7t9
         T/aqDlqVEvM7lWQunB3VRwhx1TrP+7FVMli3digtSnmCmLHqQYwHLWA+zgEGE6RyeROF
         3VMs0XJLRfAyrtotkvn7OUR17XH16mDx9XuwhBOua7nZZD0MXSGBfVAjnFnZdVdkSXQ2
         GQMw==
X-Gm-Message-State: APjAAAXVJQ9Z6oMsBlX2dI+Vx9TohoyDFIBYTMGdUbyUKYUisaMNF1qw
        FKF/VSiD7jAtxiEUYuDn1hmN3tBadj4=
X-Google-Smtp-Source: APXvYqwHLhyYRnFygxcwd0JVmYFTKoIg5/yuAksaT+lO4F4n2L964F6S7MXiUgAT24cAQc34TulPWQ==
X-Received: by 2002:a02:c7c7:: with SMTP id s7mr6803081jao.37.1561575845406;
        Wed, 26 Jun 2019 12:04:05 -0700 (PDT)
Received: from x220t.lan ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id k5sm18446041ioj.47.2019.06.26.12.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 12:04:04 -0700 (PDT)
From:   Alexander Aring <aring@mojatatu.com>
To:     netdev@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel@mojatatu.com,
        Alexander Aring <aring@mojatatu.com>
Subject: [RFC iproute2 0/1] iproute2 netns mount race issue and solution?
Date:   Wed, 26 Jun 2019 15:03:42 -0400
Message-Id: <20190626190343.22031-1-aring@mojatatu.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We found an issue how we can react on namespaces created by iproute2.
As state of the current Linux kernel there exists no way to get events
on new mounts. Polling is not an option because you can miss mounts.

It's an RFC to see that might people seeing the same issue here and
would like to talk about possible solutions how to deal with that.

I cc linux-fs here that they might can tell me a solution which maybe
already exists if not this solution should be backwards compatible.

I know this solution only works for iproute2 but isn't iproute2 not the
standard defintion how /var/run/netns works?

- Alex

Alexander Aring (1):
  ip: netns: add mounted state file for each netns

 ip/ipnetns.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.11.0

