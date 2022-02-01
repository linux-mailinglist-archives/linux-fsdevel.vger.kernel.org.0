Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE04A5D96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 14:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiBANnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 08:43:50 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:43718 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbiBANnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1643723029;
        bh=uDxFPxbUo1MGB82BrefKPM3fJAGFfZccgORo64UPMRc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Hf2rxqKEVSX4jxK5SJEx3GK0ItD2CuaL1uvIaDfjqf0qDvPbxbZOug+2kR8E+cOJ7
         IMP8/OoVXoXCGjWfKV9REMzq6IzmCEZeMNsXWoTLlD8UPMXXHyf1Cqtq+4XFEtzH44
         5qP7QgLQkVvAlrCgk+2rHIFJyuK2OYC4OSz1COj8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C33541280C67;
        Tue,  1 Feb 2022 08:43:49 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iq5iSiTKdxO8; Tue,  1 Feb 2022 08:43:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1643723029;
        bh=uDxFPxbUo1MGB82BrefKPM3fJAGFfZccgORo64UPMRc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Hf2rxqKEVSX4jxK5SJEx3GK0ItD2CuaL1uvIaDfjqf0qDvPbxbZOug+2kR8E+cOJ7
         IMP8/OoVXoXCGjWfKV9REMzq6IzmCEZeMNsXWoTLlD8UPMXXHyf1Cqtq+4XFEtzH44
         5qP7QgLQkVvAlrCgk+2rHIFJyuK2OYC4OSz1COj8=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 151651280C13;
        Tue,  1 Feb 2022 08:43:49 -0500 (EST)
Message-ID: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
Subject: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and
 fsconfig
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 01 Feb 2022 08:43:47 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A shortened version of this topic was originally sent for LSF/MM 2020
which didn't happen due to the pandemic:

https://lore.kernel.org/all/1581781497.3847.5.camel@HansenPartnership.com/

However, now replacing ioctls is on the table:

https://lore.kernel.org/all/20220201013329.ofxhm4qingvddqhu@garbanzo/

as I've already stated in that thread, I think, used sparingly, ioctls
are fit for purpose and shouldn't be replaced and I'd definitely like
to argue for that position.

However, assuming that people would like to consider alternatives, I'd
like to propose configfd.  It was originally proposed as a
configuration mechanism for bind mounts that was a more general
replacement for fsconfig (which can only configure filesystems with
superblocks) and was going to be used by shiftfs.  However, since
shiftfs functionality was done a different way, configfd has
languished, although the patches are here:

https://lore.kernel.org/all/20200215153609.23797-1-James.Bottomley@HansenPartnership.com/

The point, though, is that configfd can configure pretty much anything;
it wouldn't just be limited to filesystem objects.  It takes the
fsconfig idea of using a file descriptor to carry configuration
information, which could be built up over many config calls and makes
it general enough to apply to anything.  One of the ideas of configfd
is that the data could be made fully introspectable ... as in not just
per item description, but the ability to get from the receiver what it
is expecting in terms of configuration options (this part was an idea
not present in the above patch series).

If the ioctl debate goes against ioctls, I think configfd would present
a more palatable alternative to netlink everywhere.

James


