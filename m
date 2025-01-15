Return-Path: <linux-fsdevel+bounces-39239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818DA11C18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27373A69DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055F81E7C06;
	Wed, 15 Jan 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=thewand@web.de header.b="B3Ge2QpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8A23F260;
	Wed, 15 Jan 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930051; cv=none; b=WRJ2nC0nbRM2u7XmwOZYWzgZFNqIl6TH7Zkshv8CMDza5Jda2RwfjraFvyXGtv8YuLLjiZHcU9wC1lCIzXYkPalJufcSyvzSnkk7R/QdM0Kmstchy/falN870l5zzmWtcBA1+yFaZzsXgcIv7t7uVogWmNL2+kbtmRrENzdMfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930051; c=relaxed/simple;
	bh=0N57P/AnAVgaStKmf9dVTwcijC90xG1fVYLiY7dzxko=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=MNONMPvOmjh+ozA7OmYK2KLOcA6EAe2Ay2gAW/hsKfFt3qpcntvbCzOd4WcEqDKCA1vxxnYhsdDqo/XiLhBTBteB863qAwmGivDmU6YIwmf/qNUvWamhroHNJVXPBqxPdGd17+aymdKWqcQYL8YqshAAoSRPmj1JTfW5gycAnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=thewand@web.de header.b=B3Ge2QpI; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736930046; x=1737534846; i=thewand@web.de;
	bh=0N57P/AnAVgaStKmf9dVTwcijC90xG1fVYLiY7dzxko=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B3Ge2QpInACX83ND5wIRRzSu62OJjLRW4+SMeToogIatjzCSHTXcF0Qt0cdZ9ja5
	 kUzngWCP3ciAve/2Ugn5FQrN5Bccqn8txd+gosQalSmSqSSUiS9oEsaW/twB0RGJQ
	 /DttYGnxdLAqkw9+C8zHrg13ayE+NyS2y5369ukvuUF5Q0/4SaO0jVt5Iz4vY4diC
	 wy5zA66wwoH7wzcf1WKqEf71muxWWyb4omoCh30UG+n71H2Covp8xUWERskPl/V8s
	 5MNdHsJbYUZ5Rmce16a+AH6mLUQJT1ri2JQpU8KCSV5n7OfKYIdi75CyePdPQlaUc
	 /5zG+X0jiUmZN8KMOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.142] ([87.189.178.119]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzTLO-1tKpe23ANk-00wJMa; Wed, 15
 Jan 2025 09:34:06 +0100
Message-ID: <f20639eaa10eaa327dc9a294164b731215d5212f.camel@web.de>
Subject: Two questions on sparse files
From: Andreas Wagner <thewand@web.de>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Date: Wed, 15 Jan 2025 09:34:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:q+LUffMs+1GtHhPyY84cm0t2OVnw7rGVZkmQaTObODZP4uyWtA4
 IZP3X6BRpL26DgNcPUpRqvKdlPKxmuzmOqovw99baMNHsuUsIQsfYQjgEJhGpW1Un9P+AnW
 +5CrBADpuCaDXL7iCZNlLBavEK68YFHYdB2XLBKR+KAriOPQbjo7h5MJQSjN5F+sE7B6OP/
 8cyATG4CS0gtjtXWq3lsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jnR4H8ctUAI=;z7ZLXxiSijc3+Ou1kqoI7QvYNa8
 RLEvx3rXSnaO8/UeiSVdsN7wOjYUwPYfcLzot07ItPzrlGZRFBWpEdQAAVsz6A1GTrEhuLDIY
 pCe7Q1El4drWEJXG11COGAJADrZFWfW8+DRAgkeKzo8in8acBe0tXIZOAcRliJlFbIsHtIbIW
 PdAUS8lD0mg31a9JUoeDCZ6/35aq7kmj/u3nIIvil3jb8JWNuG5gDTELXOyHjpF4ZM4MRr0ud
 StU1o/yoaJh1/9fR9EeGDi+eL3q9+gjXXNF1xDF+XvSGYd0HGbaFZsLGDkWFgedmabBfcgGxi
 peo5xapDt19Fb31nO8eviFo0B3CvRbgGUgSpc79LMn5R8FXc/i12/os56VwpAkzT8JUktQvot
 ZaVh9lzNQ0WrRZl9YCpHmkkyNig7Oh34TusiIeObibI3gAne+Nk5hSQOmaProX9BaW+CiH/SH
 4NlBp0jUprvxp/fDeK3jcOd8rjX+FfoubtwLDzU6E4DZMsTux1dvcV7ZNakhS0VS3ySxWxMZN
 DHL3PHiiNnD2gubKRjvfHaIG1JnxV1PNibs30fWTMtRv7gMIsHnPVyCNEaCX89q0PM8KUxUcQ
 fLhHw0APQMCC2aX9jQ7d3TmdAo/ey7EAA1ClsIvBlEXzpcWjwBMGmer+3VKwPSII+eSEtBbAv
 MJoDg8AHry8+1LuKKbWp7JTuzxRc67FfdolAdseOd+PXiE8ChRDCtYQsz/nBJSTtmRJD+Io5U
 BF5iYzntqXuyEfT7zPWrD7ikLcFCXhFWPXttHT97F7JHuHDgmnNa9n1Irak12cyMVVXHMsy5B
 u1oDzt9D+30On+Y5AuHeC3tb0GQaqv5O2Rmyao9ZScI2uY/wW1Y5S/nm23CReRvCWVxR47Vzo
 gRG2k7n74dg6AqLMUu3IaniiYb9p4OJvcMKXwso1Wuh/+bIZud1Ka6K2ZAEtskZsbhDqqCM6Z
 V0vE2/DrA7dRTNYh5xSv3n03eFH5/IUiL69vHSRn0YOxCCk0aR7DEy3YTKQ29OO2yuEE2YSP7
 AwV+Fb19suz9LX/J9rpXDJejx9ZZbxG5jfkzX0U6bf0VOs0IK3BaS7dkoxc2qpSo0vPD6tQ36
 VWhqNZ+HiLzp1k66IFKuK0wBAdbasBtO/izCFXuL/ECQgwtZSQlRonZZoAYbkEoIF65plNoaA
 zD2cDceUo+NRbsrti0e+8GYBkMBdA3cFHgS5M/PPcLQ==

Hello,

I have two questions on sparse files:

1. Do they really - as media and Wikipedia suggest - reduce allocated
filesize if the file is sparse?=20
2. Are the blocks of the file in random order?

Thanks in advance and regards,
Andreas Wagner

